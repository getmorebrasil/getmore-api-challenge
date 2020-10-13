defmodule Market.Shops do
  @moduledoc """
  The Bottlers context.

  Note: Its was a dataloader to resolve the N+1 problem
  """

  import Ecto.Query, warn: false
  alias Market.Repo
  alias __MODULE__.{Product}
  #######################
  # GENERAL COMPOSITION #
  #######################

  defp pagination_query(struct, args) do
    # default page size
    struct =
      struct
      |> limit(50)

    Enum.reduce(args, struct, fn
      {:page, page}, query ->
        # page validation
        if page > 0 do
          query |> offset(^page - 1)
        else
          query
        end

      {:page_size, page_size}, query ->
        # page size validation and limit
        if page_size >= 0 and page_size <= 50 do
          query |> limit(^page_size)
        else
          query
        end

      _, query ->
        query
    end)
  end

  defp filter_names_query(struct, args) do
    Enum.reduce(args, struct, fn
      {:filter_names, names}, query ->
        from x in query, where: x.name in ^names

      _, query ->
        query
    end)
  end

  defp product_filter_query(struct, args) do
    Enum.reduce(args, struct, fn
      {:price_min, price_min}, query ->
        from b in query, where: b.price >= ^price_min

      {:price_max, price_max}, query ->
        from b in query, where: b.price <= ^price_max

      {:stock_min, stock_min}, query ->
        from b in query, where: b.stock >= ^stock_min

      {:stock_max, stock_max}, query ->
        from b in query, where: b.stock <= ^stock_max

      {:category, category}, query ->
        from b in query, where: b.category <= ^category

    end)
  end

  ########
  # SHOP #
  ########

  alias Market.Shops.Product

  @doc """
  Returns the list of providers.

  ## Examples

      iex> list_providers()
      [%Provider{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  def list_products(args) do
    pagination_query(Product, args)
    |> filter_names_query(args)
    |> product_filter_query(args)
    |> Repo.all()
  end

  @doc """
  Gets a single provider.

  Raises `Ecto.NoResultsError` if the Provider does not exist.

  ## Examples

      iex> get_provider!(123)
      %Provider{}

      iex> get_provider!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a provider.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a provider.

  ## Examples

      iex> delete_provider(provider)
      {:ok, %Provider{}}

      iex> delete_provider(provider)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end
end
