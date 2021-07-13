defmodule Catalog.UseCases.GetProduct do
  import Ecto.Query, only: [from: 2]

  alias Catalog.Repo
  alias Catalog.Schemas.Product

  def call(params) do
    params
    |> build_query()
    |> get_products()
  end

  defp build_query(%{"current_page" => current_page, "page_size" => page_size})
       when is_integer(current_page) and is_integer(page_size) do
    query = from Product, limit: ^page_size, offset: ^calc_offset(current_page, page_size)

    {:ok, query}
  end

  defp build_query(:all), do: {:ok, Product}

  defp build_query(_), do: {:error, "invalid params"}

  defp get_products({:ok, query}), do: {:ok, Repo.all(query)}

  defp get_products({:error, reason}), do: {:error, reason}

  defp calc_offset(current, size), do: current * size - size
end
