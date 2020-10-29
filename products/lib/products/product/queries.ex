defmodule Products.Product.Queries do
  @moduledoc """
  Provides methods to fetch products from DB
  """

  alias Products.{Repo, Product}

  @doc """
  Returns a list of products paginated using the given parameters to select the page and the page size
  """
  def get_page(params \\ %{page: 1, page_size: 10}) do
    Product
    |> Repo.all()
    |> Repo.paginate(params)
  end
end
