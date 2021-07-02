defmodule QatalogData.Products.Consumer do
  @moduledoc false

  use GenServer
  use AMQP

  alias AMQP.Connection
  alias QatalogData.Products.MessageHandler

  def start_link(_params) do
    GenServer.start_link(__MODULE__, [], [])
  end

  @exchange "qatalog_exchange"
  @queue "qatalog_queue"
  @queue_error "#{@queue}_error"
  @rabbitmq_url "amqp://guest:guest@localhost"

  def init(_opts) do
    {:ok, conn} = Connection.open(@rabbitmq_url)
    {:ok, chan} = Channel.open(conn)
    setup_queue(chan)

    # Limit unacknowledged messages to 10
    :ok = Basic.qos(chan, prefetch_count: 10)
    # Register the GenServer process as a consumer
    {:ok, _consumer_tag} = Basic.consume(chan, @queue)
    {:ok, chan}
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, channel),
    do: {:noreply, channel}

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, channel),
    do: {:stop, :normal, channel}

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, channel),
    do: {:noreply, channel}

  def handle_info({:basic_deliver, payload, meta}, channel) do
    Task.async(fn ->
      consume(channel, payload, meta)
    end)
    |> Task.await()

    {:noreply, channel}
  end

  defp consume(channel, payload, meta) do
    response = payload
    |> MessageHandler.decode_payload()
    |> MessageHandler.process_message()
    |> MessageHandler.encode_response()

    :ok = Basic.publish(channel, "", meta.reply_to, response, correlation_id: meta.correlation_id)

    :ok = Basic.ack(channel, meta.delivery_tag)
  rescue
    exception ->
      :ok = Basic.reject(channel, meta.delivery_tag, requeue: not meta.redelivered)
      IO.puts(exception)
  end

  defp setup_queue(chan) do
    {:ok, _} = Queue.declare(chan, @queue_error, durable: true)

    {:ok, _} =
      Queue.declare(chan, @queue,
        durable: true,
        arguments: [
          {"x-dead-letter-exchange", :longstr, ""},
          {"x-dead-letter-routing-key", :longstr, @queue_error}
        ]
      )

    :ok = Exchange.fanout(chan, @exchange, durable: true)
    :ok = Queue.bind(chan, @queue, @exchange)
  end
end
