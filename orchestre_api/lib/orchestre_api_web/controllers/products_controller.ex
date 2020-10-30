defmodule OrchestreApiWeb.ProductsController do
  @moduledoc """
  Handle http calls to products service
  """

  use OrchestreApiWeb, :controller
  alias OrchestreApi.Products.Publisher

  @doc """
  List products paginated by the given params
  """
  def index(conn, %{"page" => page, "page_size" => page_size}) do
    products = Publisher.rpc_call(page, page_size)

    conn
    |> put_status(:ok)
    |> json(products)
  end
end
