defmodule Marketplace do
  use GenServer
  use AMQP

  def start_link(_state) do
    GenServer.start_link(__MODULE__, [], [])
  end

  @exchange "gen_server_test_exchange"
  @queue "rpc_queue"
  @queue_error "#{@queue}_error"
  @rmq_uri "amqp://rabbitmq:5672"

  def init(_opts) do
    {:ok, conn} = Connection.open(@rmq_uri)
    {:ok, chan} = Channel.open(conn)
    setup_queue(chan)

    # Limit unacknowledged messages to 10
    :ok = Basic.qos(chan, prefetch_count: 10)
    # Register the GenServer process as a consumer
    {:ok, _consumer_tag} = Basic.consume(chan, @queue)
    {:ok, chan}
  end

  def handle_info({:basic_deliver, payload, meta}, chan) do
    # You might want to run payload consumption in separate Tasks in production
    consume(chan, meta, payload)
    {:noreply, chan}
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  defp setup_queue(channel) do
    AMQP.Queue.declare(channel, "rpc_queue")
    AMQP.Basic.qos(channel, prefetch_count: 1)
    AMQP.Basic.consume(channel, "rpc_queue")
    IO.puts(" [x] Awaiting RPC requests")
  end

  defp consume(
         channel,
         %{delivery_tag: tag, reply_to: reply_to, correlation_id: correlation_id},
         payload
       ) do
    response =
      payload
      |> normalize_payload()
      |> IO.inspect()
      |> Marketplace.Product.Index.call()

    AMQP.Basic.publish(
      channel,
      "",
      reply_to,
      Jason.encode!(response),
      correlation_id: correlation_id
    )

    AMQP.Basic.ack(channel, tag)
  end

  defp normalize_payload(payload), do: Jason.decode!(payload)
end
