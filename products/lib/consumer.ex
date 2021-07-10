defmodule Products.Consumer do
  @moduledoc """
  I handle messages from rabbitMQ to get products
  """
  use AMQP
  use GenServer

  require Logger

  @content_type "application/json"
  @exchange "products_exchange"
  @queue "products_queue"
  @queue_error "#{@queue}_error"

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_opts) do
    start_connection()
  end

  # Confirmation sent by the broker after registering this process as a consumer
  def handle_info({:basic_consume_ok, _}, chan), do: {:noreply, chan}

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  def handle_info({:basic_cancel, _}, chan), do: {:stop, :normal, chan}

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  def handle_info({:basic_cancel_ok, _}, chan), do: {:noreply, chan}

  # Reconnect server on process failure
  def handle_info({:DOWN, _, :process, _pid, _reason}, _) do
    {:ok, chan} = start_connection()
    {:noreply, chan}
  end

  # handle published messages
  def handle_info({:basic_deliver, payload, meta}, chan) do
    spawn(fn -> consume(chan, payload, meta) end)
    {:noreply, chan}
  end

  # start the connection and handle reconnection
  defp start_connection do
    case Connection.open(get_rabbitmq_uri()) do
      {:ok, conn} ->
        Process.monitor(conn.pid)
        setup_connection(conn)

      {:error, _} ->
        Logger.error("Failed to connect on rabbitMQ server, retrying in 10 seconds")
        :timer.sleep(10_000)
        start_connection()
    end
  end

  # setup the connection and declare the queues with exchanges
  defp setup_connection(conn) do
    {:ok, chan} = Channel.open(conn)
    Basic.qos(chan, prefetch_count: 100)
    Queue.declare(chan, @queue_error, durable: true)

    Queue.declare(chan, @queue,
      durable: true,
      arguments: [
        {"x-dead-letter-exchange", :longstr, ""},
        {"x-dead-letter-routing-key", :longstr, @queue_error}
      ]
    )

    Exchange.fanout(chan, @exchange, durable: true)
    Queue.bind(chan, @queue, @exchange)
    {:ok, _} = Basic.consume(chan, @queue)
    {:ok, chan}
  end

  # handle message to get products
  defp consume(channel, payload, %{
         reply_to: reply_to,
         correlation_id: correlation_id,
         delivery_tag: delivery_tag
       }) do
    case Jason.decode(payload) do
      {:ok, params} ->
        {:ok, products} =
          params
          |> Products.list()
          |> Jason.encode()

        Basic.publish(
          channel,
          "",
          reply_to,
          products,
          correlation_id: correlation_id,
          content_type: @content_type
        )

        Basic.ack(channel, delivery_tag)

      _ ->
        Basic.reject(channel, delivery_tag, requeue: false)
    end
  rescue
    _ -> Basic.reject(channel, delivery_tag, requeue: false)
  end

  # get connection uri from config
  defp get_rabbitmq_uri do
    :products
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:rabbitmq_uri)
  end
end
