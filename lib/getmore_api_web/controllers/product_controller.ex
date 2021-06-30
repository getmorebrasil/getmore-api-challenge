defmodule GetmoreApiWeb.ProductController do
  use GetmoreApiWeb, :controller

  alias GetmoreApi.Store
  alias GetmoreApi.Store.Product

  action_fallback GetmoreApiWeb.FallbackController

  def index(conn, _params) do
    products = Store.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Store.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end
end
