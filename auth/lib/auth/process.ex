defmodule Auth.Process do

  @doc """
  This function is responsible for validating the token passed
  """
  @spec process_token(any) :: :error | :ok
  def process_token token do
    resp = if token == "abc123" do
      :ok
    else
      :error
    end
    IO.puts resp
    resp
  end
end
