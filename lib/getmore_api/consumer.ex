defmodule GetmoreApi.Consumer do
  use GenServer
  use AMQP

  alias GetmoreApi.Store

  def start_link(opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @exchange "products_exchange"
  @queue "products_queue"
  @queue_error "#{@queue}_error"

  def init(_opts) do
    {:ok, connection} = Connection.open()

    case Channel.open(connection) do
      {:ok, channel} ->
        setup_queue(channel)

        :ok = Basic.qos(channel, prefetch_count: 100)
        {:ok, _consumer_tag} = Basic.consume(channel, @queue)
        {:ok, channel}

      {:error, _} ->
        :timer.sleep(1)
        Channel.open(connection)
    end
  end

  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, channel) do
    {:noreply, channel}
  end

  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, channel) do
    {:stop, :normal, channel}
  end

  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, channel) do
    {:noreply, channel}
  end

  def handle_info({:basic_deliver, payload, meta}, channel) do
    consume(channel, meta, payload)
    {:noreply, channel}
  end

  defp setup_queue(channel) do
    {:ok, _} = Queue.declare(channel, @queue_error, durable: true)

    {:ok, _} =
      Queue.declare(channel, @queue,
        durable: true,
        arguments: [
          {"x-dead-letter-exchange", :longstr, ""},
          {"x-dead-letter-routing-key", :longstr, @queue_error}
        ]
      )

    :ok = Exchange.fanout(channel, @exchange, durable: true)
    :ok = Queue.bind(channel, @queue, @exchange)
  end

  defp consume(channel, meta, payload) do
    {:ok, params} = Poison.decode(payload)

    {:ok, data} = Store.list_products(params) |> Poison.encode()

    opts = [content_type: "application/json", correlation_id: meta.correlation_id]

    :ok = AMQP.Basic.ack(channel, meta.delivery_tag)
    :ok = AMQP.Basic.publish(channel, "", meta.reply_to, data, opts)
    IO.puts("rabbitmq - [X] Received params: #{payload}")
  rescue
    exception ->
      :ok = AMQP.Basic.reject(channel, meta.delivery_tag, requeue: not meta.redelivered)
      IO.inspect(exception)
  end
end
