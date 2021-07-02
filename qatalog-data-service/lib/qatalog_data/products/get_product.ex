defmodule QatalogData.Products.GetProduct do
  @moduledoc false

  alias QatalogData.{Product, Repo}

  @doc """
    Gets the `Product` according with the given id

    ## Parameters
    - id: The `Product` id

    ## Examples
      \tiex> 1001 |> GetCatalog.call()\f
      \t%Product{...}

      \tiex> 1 |> GetCatalog.call()\f
      \t%{error: "Oops! No products were found with the id 1" }
  """
  @spec call(integer()) :: Product.t() | Map.t()
  def call(id) do
    case Repo.get_by(Product, id: id) do
      %Product{} = result -> result
      nil -> %{error: "Oops! No products were found with the id #{id}" }
    end
  end
end
