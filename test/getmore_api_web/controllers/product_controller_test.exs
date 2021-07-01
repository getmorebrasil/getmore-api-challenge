defmodule GetmoreApiWeb.ProductControllerTest do
  use GetmoreApiWeb.ConnCase

  alias GetmoreApi.Store
  alias GetmoreApi.Store.Product

  @create_attrs %{
    product_category: "some product_category",
    product_id: 42,
    product_image: "some product_image",
    product_name: "some product_name",
    product_price: 120.5,
    product_stock: true
  }
  @invalid_attrs %{
    product_category: nil,
    product_id: nil,
    product_image: nil,
    product_name: nil,
    product_price: nil,
    product_stock: nil
  }

  def fixture(:product) do
    {:ok, product} = Store.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      response = json_response(conn, 200)["data"]
      assert response == []
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    %{product: product}
  end
end
