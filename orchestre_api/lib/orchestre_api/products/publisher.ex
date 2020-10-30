defmodule OrchestreApi.Products.Publisher do
  @moduledoc """
  Provides methods to send AMQP messagens and wait for response by RPC calls.
  """

  @products_exchange "product_consumer"
  @json_content "application/json"

  @doc """
  Wait for the response from the products service when make a RPC call.
  """
  def wait_for_messages(_channel, correlation_id) do
    receive do
      {:basic_deliver, payload, %{correlation_id: ^correlation_id}} -> payload
    end
  end


  @doc """
  Starts a connection, open a channel and starts a queue to do a RPC call to products service
  """
  def rpc_call(page, page_size) do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    {:ok, %{queue: queue_name}} = AMQP.Queue.declare(channel,
                                                     "",
                                                     exclusive: true)
    AMQP.Basic.consume(channel, queue_name, nil, no_ack: true)

    correlation_id = gen_correlation_id()
    message = encode_message(%{page: page, page_size: page_size})

    AMQP.Basic.publish(channel,
                       @products_exchange,
                       "",
                       message,
                       reply_to: queue_name,
                       correlation_id: correlation_id,
                       content_type: @json_content)

    wait_for_messages(channel, correlation_id)
  end

  # Generates a unique correlation id to track the RPC response
  defp gen_correlation_id(), do: :erlang.unique_integer |> :erlang.integer_to_binary |> Base.encode64

  defp encode_message(map) do
    {:ok, message} = Jason.encode(map)
    message
  end
end
