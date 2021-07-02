defmodule QatalogData.Products.MessageHandler do
  @moduledoc false

  @doc """
    Decodes the message payload received from RabbitMQ to a Map

    ## Parameters
    - payload: `String` that represents the payload data received from RabbitMQ

    ## Examples
        \tiex> payload = "{\\\"message\\\": \\\"Hello\\\"}"
        \tiex> payload |> MessageHandler.decode_payload()\f
        \t%{"message" => "Hello"}
  """
  @spec decode_payload(String.t()) :: {:ok, Map.t()} | {:error, Jason.DecodeError.t()}
  def decode_payload(payload) do
    Jason.decode(payload, %{})
  end

  @doc """
    Processes the id given in the params

    ## Parameters
    - decoded_payload: `Tuple` that has an `:ok` and a `Map` with the id of the `Product` or the query params
      or an `:error` and an error message.

    ## Examples
      \tiex> {:ok, %{"id" => "1001"}} |> MessageHandler.process_message()\f
      \t%Product{...}

      \tiex> {:ok, %{}} |> MessageHandler.process_message()\f
      \t[%Product{...}, %Product{...}, %Product{...}, ...]

      \tiex> {:error, "A big and scary error"} |> MessageHandler.process_message()\f
      \t%{error: "Oops! The given params are invalid"}
  """
  @spec process_message({:ok, Map.t()}) :: Product.t() | Map.t()
  def process_message({:ok, %{"id" => id}} = _params) do
    id |> String.to_integer() |> QatalogData.Products.GetProduct.call()
  rescue
    _exception ->
      %{error: "Oops! A invalid id was found"}
  end

  @spec process_message({:ok, Map.t()}) :: List.t() | Map.t()
  def process_message({:ok, params}) do
    params |> QatalogData.Products.GetCatalog.call()
  end

  @spec process_message({:error, any()}) :: Map.t()
  def process_message({:error, _reason}), do: %{error: "Oops! The given params are invalid"}

  @doc """
    Encodes the response to a `String`

    ## Parameters
    - param: A `Product` struct, a `Map` or a `List` to be encoded as a JSON

    ## Examples
        \tiex> response = %{message: "Hello"}
        \tiex> response |> MessageHandler.encode_response()\f
        \t"{\\\"message\\\": \\\"Hello\\\"}"
  """
  @spec encode_response(Product.t() | Map.t() | List.t()) :: String.t()
  def encode_response(response) do
    {:ok, encoded_response} = Jason.encode(response, %{})
    encoded_response
  end
end
