defmodule GetmoreApi.Store do
  @moduledoc """
  The Store context.
  """

  import Ecto.Query, warn: false
  alias GetmoreApi.Repo
  alias GetmoreApi.Store.Product
  alias GetmoreApi.Paginator

  def list_products(params) do
    Product
    |> order_by(asc: :product_id)
    |> Paginator.new(params)
  end

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end
end
