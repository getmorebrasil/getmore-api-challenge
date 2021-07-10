defmodule Products do
  @moduledoc """
  Product context.
  """
  import Ecto.Query

  alias Products.{Product, Repo}

  @typedoc """
  List params definition
  """
  @type list_params :: %{
          optional(:page) => integer(),
          optional(:page_size) => integer()
        }

  @spec list() :: list(Product.t())
  @spec list(list_params()) :: list(Product.t())
  @doc """
  List products by page
  """
  def list(params \\ %{}) do
    page = Map.get(params, "page", 1)
    page_size = Map.get(params, "page_size", 20)

    query =
      from p in Product,
        limit: ^page_size,
        offset: ^((page - 1) * page_size)

    Repo.all(query)
  end
end
