defmodule Api.Products.Get do
  @moduledoc """
  Handle the communication to get products with RPC requests.
  """

  alias AMQP.{Basic, Channel, Connection, Queue}
  alias Api.Error
  alias Jason.EncodeError

  @exchange "products_exchange"
  @content_type "application/json"

  @typedoc """
  Params definition
  """
  @type params :: %{
          optional(:page) => integer(),
          optional(:page_size) => integer()
        }

  @spec call() :: {:ok, list()} | {:error, Error.t()}
  @spec call(params()) :: {:ok, list()} | {:error, Error.t()}
  @doc """
  Get products from consumer
  """
  def call(params \\ %{}) do
    with {:ok, {connection, channel, queue}} <- start_connection(),
         {:ok, request} <- Jason.encode(params),
         correlation_id <- create_correlation_id(),
         :ok <- publish_request(channel, request, queue, correlation_id) do
      response = wait_response(correlation_id)
      Connection.close(connection)
      response
    else
      {:error, %EncodeError{}} -> {:error, Error.build_message_error("Invalid params")}
      _ -> build_get_error()
    end
  end

  # start connection with rabbitMQ server and define reply queue
  defp start_connection do
    with {:ok, connection} <- Connection.open(get_rabbitmq_uri()),
         {:ok, channel} <- Channel.open(connection),
         {:ok, %{queue: queue}} <- Queue.declare(channel, "", exclusive: true),
         {:ok, _} <- Basic.consume(channel, queue, nil, no_ack: true) do
      {:ok, {connection, channel, queue}}
    end
  end

  # publish message to get products
  defp publish_request(channel, request, reply_to, correlation_id) do
    Basic.publish(
      channel,
      @exchange,
      "",
      request,
      reply_to: reply_to,
      correlation_id: correlation_id,
      content_type: @content_type
    )
  end

  # wait to response on reply queue
  defp wait_response(correlation_id) do
    receive do
      {:basic_deliver, payload, %{correlation_id: ^correlation_id}} ->
        case Jason.decode(payload) do
          {:ok, _} = response -> response
          {:error, _} -> build_get_error()
        end
    after
      5_000 -> build_get_error()
    end
  end

  # create unique request id
  defp create_correlation_id do
    :erlang.unique_integer()
    |> :erlang.integer_to_binary()
    |> Base.encode64()
  end

  # build get products error
  defp build_get_error do
    {:error, Error.build_message_error("Failed to get the products")}
  end

  # get connection uri from config
  defp get_rabbitmq_uri do
    :api
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:rabbitmq_uri)
  end
end
