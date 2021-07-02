defmodule QatalogData.Products.GetCatalog do
  @moduledoc false

  alias QatalogData.{Product, Repo}
  import Ecto.Query

  @doc """
    Gets the catalog of `Product`s according with the given parameters

    ## Parameters
    - params: A Map that contains the query parameters

    ## Examples
      \tiex> %{} |> GetCatalog.call()\f
      \t[%Product{...}, %Product{...}, %Product{...}, ...]
  """
  @spec call(Map.t()) :: List.t()
  def call(params) do
    query =
      init_query()
      |> handle_items_per_page(params)
      |> handle_category(params)
      |> handle_in_stock?(params)
      |> handle_order_by_price(params)

    from(p in query, select: p)
    |> Repo.all()
  end

  @spec init_query() :: Ecto.Queryable.t()
  defp init_query() do
    result = from p in Product
    result
  end

  @spec handle_order_by_price(Ecto.Queryable.t(), Map.t()) :: Ecto.Queryable.t()
  defp handle_order_by_price(query, params) do
    case params do
      %{"orderByPrice" => "asc"} ->
        result = from p in query, order_by: [asc: p.price]
        result

      %{"orderByPrice" => "desc"} ->
        result = from p in query, order_by: [desc: p.price]
        result

      _ -> query
    end
  end

  @spec handle_in_stock?(Ecto.Queryable.t(), Map.t()) :: Ecto.Queryable.t()
  defp handle_in_stock?(query, params) do
    case params do
      %{"inStock" => "true"} ->
        result = from p in query, where: p.stock == true
        result

      %{"inStock" => "false"} ->
        result = from p in query, where: p.stock == false
        result

      _ -> query
    end
  end

  @spec handle_category(Ecto.Queryable.t(), Map.t()) :: Ecto.Queryable.t()
  defp handle_category(query, params) do
    case params do
      %{"category" => category} ->
        result = from p in query, where: p.category == ^category
        result

      _ -> query
    end
  end

  @spec handle_items_per_page(Ecto.Queryable.t(), Map.t()) :: Ecto.Queryable.t()
  defp handle_items_per_page(query, params) do
    case params do
      %{"items" => items, "page" => page} ->
        items = String.to_integer(items)
        page = String.to_integer(page)
        skipped_items = items * (page - 1)

        result = from p in query, limit: ^items, offset: ^skipped_items
        result

      %{"page" => page} ->
        page = String.to_integer(page)
        skipped_items = 10 * (page - 1)

        result = from p in query, limit: 10, offset: ^skipped_items
        result

      %{"items" => items} ->
        items = String.to_integer(items)

        result = from p in query, limit: ^items, offset: 0
        result

      _ ->
        result = from p in query, limit: 10, offset: 0
        result
    end
  end
end
