defmodule QatalogApi.Products.Publisher do
  @moduledoc """
    QatalogApi.Products.Publisher provides functions to publish a message in a RabbitMQ service and handle its response.
  """

  @exchange     "qatalog_exchange"
  @queue        "qatalog_queue"
  @rabbitmq_url "amqp://guest:guest@localhost"

  alias AMQP.{Basic, Channel, Connection, Exchange, Queue}
  use AMQP

  @doc """
    Publishes a message in RabbitMQ service

    ## Parameters

    - params: Map that represents the query params and/or body of a request

    ## Examples

      iex> Publisher.publish_message(%{})
      []

      iex> Publisher.publish_message(%{"id" => 1001})
      %{}
  """
  @spec publish_message(Map.t()) :: Map.t() | list()
  def publish_message(params) do
    {:ok, conn} = Connection.open(@rabbitmq_url)
    {:ok, channel} = Channel.open(conn)

    callback_queue = create_callback_queue(channel)
    correlation_id =
      :erlang.unique_integer()
      |> :erlang.integer_to_binary()
      |> Base.encode64()

    {:ok, encoded_params} = Jason.encode(params)

    # Publish the message in the queue
    Basic.publish(channel, @exchange, @queue, encoded_params,
      reply_to: callback_queue,
      correlation_id: correlation_id
    )

    handle_queue_response(channel, correlation_id)
  end

  @spec handle_queue_response(Connection.t(), binary()) :: Map.t()
  defp handle_queue_response(channel, correlation_id) do
    receive do # When the response arrives
      {:basic_deliver, payload, %{correlation_id: ^correlation_id}} ->
        # Close the connection and deletes the queue of response
        Channel.close(channel)
        {:ok, decoded_params} = Jason.decode(payload)
        decoded_params
    end
  end

  @spec create_callback_queue(Channel.t()) :: Basic.queue()
  defp create_callback_queue(channel) do
    # Declares the queue of response
    #{:ok, %{queue: callback_queue}} = Queue.declare(channel, "", exclusive: true, auto_delete: true)
    {:ok, %{queue: callback_queue}} = Queue.declare(channel, "", exclusive: true)
    # Listen to the queue
    Basic.consume(channel, callback_queue, nil, no_ack: true)

    callback_queue
  end
end
