defmodule Catalog.Consumers.GetProducts do
  use GenServer
  use AMQP

  alias Catalog.Response

  @amqp_uri System.get_env("AMQP_URI", "amqp://localhost:5672")

  @exchange "products_exchange"
  @queue "get_products_queue"
  @routing_key "get"

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_opts) do
    {:ok, connection} = Connection.open(@amqp_uri)
    {:ok, channel} = Channel.open(connection)

    :ok = setup_queue(channel, @exchange, @queue, @routing_key)
    :ok = Basic.qos(channel, prefetch_count: 10)
    {:ok, _} = Basic.consume(channel, @queue)
    {:ok, channel}
  end

  def handle_info({:basic_consume_ok, _}, channel), do: {:noreply, channel}

  def handle_info({:basic_cancel, _}, channel), do: {:stop, :normal, channel}

  def handle_info({:basic_cancel_ok, _}, channel), do: {:noreply, channel}

  def handle_info({:basic_deliver, payload, meta}, channel) do
    consume(channel, payload, meta)

    {:noreply, channel}
  end

  defp setup_queue(chan, exchange, queue, routing_key) do
    with {:ok, _} <- Queue.declare(chan, queue, durable: true),
         :ok <- Exchange.direct(chan, exchange, durable: true),
         :ok <- Queue.bind(chan, queue, exchange, routing_key: routing_key) do
      :ok
    else
      {:error, _} = error -> error
    end
  end

  defp consume(channel, payload, meta) do
    response = Response.handler(payload, meta)

    :ok =
      Basic.publish(
        channel,
        "",
        meta.reply_to,
        response,
        correlation_id: meta.correlation_id
      )

    :ok = Basic.ack(channel, meta.delivery_tag)
  rescue
    _exception ->
      :ok = Basic.reject(channel, meta.delivery_tag, requeue: not meta.redelivered)
  end
end
