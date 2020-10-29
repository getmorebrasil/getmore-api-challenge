defmodule Products.Product.Queries do
  @moduledoc """
  Provides methods to fetch products from DB
  """

  alias Products.{Repo, Product}
  import Ecto.Query, only: [order_by: 2]

  @doc """
  Returns a list of products paginated using the given parameters to select the page and the page size
  """
  def get_page(params \\ %{page: 1, page_size: 10}) do
    Product
    |> order_by(desc: :productId)
    |> Repo.paginate(params)
    |> Map.from_struct()
  end
end
