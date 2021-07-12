defmodule CatalogApi.RPC do
  alias AMQP.{Basic, Channel, Connection, Queue}

  @amqp_uri System.get_env("AMQP_URI", "amqp://localhost:5672")

  def call(exchange, route, params) do
    with {:ok, connection} <- Connection.open(@amqp_uri),
         {:ok, channel} <- Channel.open(connection),
         {:ok, queue} <- setup_queue(channel),
         {:ok, _} <- Basic.consume(channel, queue, nil, no_ack: true) do
      request = Jason.encode!(params)

      publish(channel, exchange, route, request, queue)
      |> wait_for_response()
    end
  end

  def setup_queue(channel) do
    {:ok, %{queue: queue_name}} =
      Queue.declare(
        channel,
        "",
        exclusive: true
      )

    {:ok, queue_name}
  end

  def gen_correlation_id do
    :erlang.unique_integer()
    |> :erlang.integer_to_binary()
    |> Base.encode64()
  end

  defp publish(channel, exchange, routing_key, request, queue) do
    correlation_id = gen_correlation_id()

    with :ok <-
           Basic.publish(
             channel,
             exchange,
             routing_key,
             request,
             reply_to: queue,
             correlation_id: correlation_id,
             content_type: "application/json"
           ) do
      {:ok, correlation_id}
    else
      {:error, _error} = error -> error
    end
  end

  defp wait_for_response({:ok, correlation_id}) do
    receive do
      {:basic_deliver, payload, %{correlation_id: ^correlation_id}} ->
        Jason.decode(payload)
    after
      10_000 -> {:error, "rpc request timeout"}
    end
  end

  defp wait_for_response({:error, error}) do
    case error do
      :blocked -> {:error, "rpc server is blocked"}
      :closing -> {:error, "rpc server is closing"}
    end
  end
end
