defmodule ApiWeb.ProductsController do
  use ApiWeb, :controller

  alias ApiWeb.FallbackController
  alias ApiWeb.ProductsValidator, as: Validator

  action_fallback FallbackController

  def index(conn, params) do
    with {:ok, params} <- Validator.index(params),
         {:ok, products} <- Api.get_products(params) do
      conn
      |> put_status(:ok)
      |> render("products.json", products: products)
    end
  end
end
