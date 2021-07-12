defmodule Catalog.Response do
  alias Catalog.Payload
  alias Catalog.UseCases.GetProduct

  def handler(payload, meta) do
    with {:ok, params} <- Payload.parse(payload, meta.content_type),
         {:ok, result} <- GetProduct.call(params) do
      render({:ok, result})
    else
      {:error, _} = error ->
        render(error)
    end
  end

  defp render({:ok, result}) do
    data = %{result: result}

    with {:ok, payload} <- Jason.encode(data) do
      payload
    else
      {:error, error} -> render({:error, error})
      _ -> render({:error, "unexpected error"})
    end
  end

  defp render({:error, error}) do
    # IO.inspect(error)

    with {:ok, payload} <- Jason.encode(%{error: "#{error}"}) do
      payload
    end
  end
end
