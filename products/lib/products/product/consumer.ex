defmodule Products.Product.Consumer do
  @moduledoc """
  Starts the channel and the queue on the consumer to receive requests from outside
  Also provides methods to handle the received messages
  """

  use GenServer
  use AMQP
  alias Products.Product.HandleMessage

  def start_link(opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  @exchange    "product_consumer"
  @queue       "product_consumer_main_queue"
  @queue_error "#{@queue}_error"

  @doc """
  Creates the connection and the channel, setup the queue and register consumer
  """
  def init(_opts) do
    {:ok, conn} = Connection.open
    {:ok, chan} = Channel.open(conn)
    setup_queue(chan)

    # Limit unacknowledged messages to 1
    :ok = Basic.qos(chan, prefetch_count: 100)
    # Register the GenServer process as a consumer
    {:ok, _consumer_tag} = Basic.consume(chan, @queue)
    {:ok, chan}
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

  # Handle the messages in the queue
  def handle_info({:basic_deliver, payload, meta}, chan) do
    consume(chan, payload, meta)
    {:noreply, chan}
  end

  #Create the queue to receive messages
  defp setup_queue(chan) do
    {:ok, _} = Queue.declare(chan, @queue_error, durable: true)
    {:ok, _} = Queue.declare(chan, @queue,
                             durable: true,
                             arguments: [
                               {"x-dead-letter-exchange", :longstr, ""},
                               {"x-dead-letter-routing-key", :longstr, @queue_error}
                             ]
                            )
    :ok = Exchange.fanout(chan, @exchange, durable: true)
    :ok = Queue.bind(chan, @queue, @exchange)
  end

  # Handle messages and return the content required
  defp consume(channel, payload, meta) do
    response =
      payload
      |> HandleMessage.handle_message()

    AMQP.Basic.ack(channel, meta.delivery_tag)

    opts = [correlation_id: meta.correlation_id, content_type: "application/json"]
    AMQP.Basic.publish(channel,
                      "",
                      meta.reply_to,
                      response,
                      opts)
  rescue
    # Requeue unless it's a redelivered message.
    # This means we will retry consuming a message once in case of exception
    # before we give up and have it moved to the error queue
    #
    # You might also want to catch :exit signal in production code.
    # Make sure you call ack, nack or reject otherwise comsumer will stop
    # receiving messages.
    exception ->
      :ok = Basic.reject channel, meta.delivery_tag, requeue: not meta.redelivered
      IO.inspect(exception)
  end
end
