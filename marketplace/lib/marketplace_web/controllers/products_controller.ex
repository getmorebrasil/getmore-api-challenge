defmodule MarketplaceWeb.ProductsController do
  use MarketplaceWeb, :controller

  def index(conn, params) do
    products = Marketplace.index_product(params)

    conn
    |> put_status(:ok)
    |> render("index.json", products: products)
  end
end
