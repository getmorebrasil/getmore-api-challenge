defmodule Products.Product.HandleMessage do
  @moduledoc """
  Provides methods to handle a message received by the consumer
  """

  alias Products.Product.Queries

  @doc """
  Transform the string message to a map of parameters
  """
  def handle_message(message) do
    message
    |> Poison.decode!()
    |> decode_message()
    |> read_message()
  end

  # Try to decode the message, read it if success, returns error tuple if not
  defp decode_message(message) do
    case Jason.decode(message) do
      {:ok, value} -> value
      {:error, _reason} -> {:error, "O formato da mensagem é invalido"}
    end
  end

  # Send the message params to fetch data from DB and returns the data as a json stringfied
  defp read_message({:ok, value}) do
    value
    |> Queries.get_page()
    |> Jason.encode()
  end

  # Returns the error json stringfied
  defp read_message({:error, _reason} = error), do: %{error: error} |> Jason.encode()
end
