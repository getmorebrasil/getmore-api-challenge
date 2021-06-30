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
  @update_attrs %{
    product_category: "some updated product_category",
    product_id: 43,
    product_image: "some updated product_image",
    product_name: "some updated product_name",
    product_price: 456.7,
    product_stock: false
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

  describe "create product" do
    test "renders product when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.product_path(conn, :show, id))

      assert %{
               "id" => id,
               "product_category" => "some product_category",
               "product_id" => 42,
               "product_image" => "some product_image",
               "product_name" => "some product_name",
               "product_price" => 120.5,
               "product_stock" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    %{product: product}
  end
end
