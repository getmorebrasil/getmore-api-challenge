defmodule ProductsAPIWeb.ProductController do
  use ProductsAPIWeb, :controller

  alias ProductsAPI.Publisher

  action_fallback ProductsAPIWeb.FallbackController

  def index(conn, params) do
    page = Map.get(params, "page", "1")
    page_size = Map.get(params, "page_size", "10")

    data = Publisher.publish("get_products_exchange", String.to_integer(page), String.to_integer(page_size))

    render(conn, "list.json", list: data)
  end
end
