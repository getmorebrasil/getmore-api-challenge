defmodule ApiAppWeb.ProductController do
  use ApiAppWeb, :controller

  alias ApiApp.Schema
  alias ApiApp.Schema.Product

  action_fallback ApiAppWeb.FallbackController

  def index(conn, _params) do
    product = Schema.list_product()
    render(conn, "index.json", product: product)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Schema.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"product_id" => id}) do
    product = Schema.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Schema.get_product!(id)

    with {:ok, %Product{} = product} <- Schema.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Schema.get_product!(id)

    with {:ok, %Product{}} <- Schema.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
