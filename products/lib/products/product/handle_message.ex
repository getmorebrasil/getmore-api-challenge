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
    |> Jason.decode()
    |> read_message()
  end

  # Send the message params to fetch data from DB and returns the data as a json stringfied
  defp read_message({:ok, message_value}) do
    {:ok, response} =
      message_value
      |> Queries.get_page()
      |> Jason.encode()

    response
  end

  # Returns the error json stringfied
  defp read_message({:error, _reason}), do: %{error: "Invalid message format"} |> Jason.encode()
end
