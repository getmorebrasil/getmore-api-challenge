defmodule Marketplace.Product.Index do
  alias Marketplace.{Repo, Product}
  import Ecto.Query, only: [from: 2]

  def call(params) do
    query = from(p in Product, order_by: [asc: p.inserted_at, asc: p.product_id])
    products = Repo.paginate(query, params)
    convert_strutcts_to_map(products)
  end

  defp convert_strutcts_to_map(structs) do
    Enum.map(structs, fn product ->
      product
      |> Map.from_struct()
      |> Map.delete(:__meta__)
      |> Map.delete(:inserted_at)
      |> Map.delete(:updated_at)
    end)
  end
end
