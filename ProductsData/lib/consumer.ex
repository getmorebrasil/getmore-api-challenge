defmodule ProductsData.Consumer do
  use GenServer
  use AMQP

  alias ProductsData.Handler

  def start_link(opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @exchange "get_products_exchange"
  @queue "get_products_queue"
  @queue_error "#{@queue}_error"
  @amqp_uri "amqp://ihriviqq:coSZi6PeQ1dckcWi18LPW6urc9hHl8dN@orangutan.rmq.cloudamqp.com/ihriviqq"

  def init(_opts) do

    {:ok, conn} = Connection.open(@amqp_uri)

    case Channel.open(conn) do
      {:ok, chan} ->
        setup_queue(chan)

        :ok = Basic.qos(chan, prefetch_count: 100)
        {:ok, _consumer_tag} = Basic.consume(chan, @queue)
        {:ok, chan}
      {:error, _} ->
        :timer.sleep(1)
        Channel.open(conn)
    end
  end

  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  def handle_info({:basic_deliver, payload, meta}, chan) do
    consume(chan, meta, payload)
    {:noreply, chan}
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

  defp consume(channel, meta, payload) do
    {:ok, json} = Handler.load_params(payload)
    |> Handler.get_products
    |> Handler.create_response

    opts = [content_type: "application/json", correlation_id: meta.correlation_id]

    :ok = AMQP.Basic.ack(channel, meta.delivery_tag)
    :ok = AMQP.Basic.publish(channel, "", meta.reply_to, json, opts)
  rescue
    exception ->
      :ok = AMQP.Basic.reject(channel, meta.delivery_tag, requeue: not meta.redelivered)
      IO.inspect(exception)
  end
end
