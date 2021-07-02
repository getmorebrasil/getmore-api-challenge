defmodule GetmoreApiWeb.ProductController do
  use GetmoreApiWeb, :controller

  alias GetmoreApi.{Store, Publisher}
  alias GetmoreApi.Store.Product

  action_fallback GetmoreApiWeb.FallbackController

  def index(conn, params) do
    page = Map.get(params, "page", "1") |> String.to_integer()
    page_size = Map.get(params, "page_size", "10") |> String.to_integer()

    {:ok, data} =
      Publisher.publish(
        "products_exchange",
        page,
        page_size
      )
      |> Jason.decode()

    data = %{
      data: Enum.map(data["data"], fn map -> Map.delete(map, "__meta__") end),
      page: page,
      total_pages: data["total_pages"]
    }

    render(conn, :index, data: data)
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
