defmodule Marketplace.Product.Index do
  alias Marketplace.{Repo, Product}
  import Ecto.Query, only: [from: 2]

  def call(params) do
    query = from(p in Product, order_by: [asc: p.inserted_at, asc: p.product_id])
    Repo.paginate(query, params)
  end
end
