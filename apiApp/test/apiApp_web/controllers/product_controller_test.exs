defmodule ApiAppWeb.ProductControllerTest do
  use ApiAppWeb.ConnCase

  alias ApiApp.Schema
  alias ApiApp.Schema.Product

  @create_attrs %{
    product_category: "some product_category",
    product_id: 42,
    product_image: "some product_image",
    product_name: "some product_name",
    product_price: "some product_price",
    product_stock: true
  }
  @update_attrs %{
    product_category: "some updated product_category",
    product_id: 43,
    product_image: "some updated product_image",
    product_name: "some updated product_name",
    product_price: "some updated product_price",
    product_stock: false
  }
  @invalid_attrs %{product_category: nil, product_id: nil, product_image: nil, product_name: nil, product_price: nil, product_stock: nil}

  def fixture(:product) do
    {:ok, product} = Schema.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all product", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
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
               "product_price" => "some product_price",
               "product_stock" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product" do
    setup [:create_product]

    test "renders product when data is valid", %{conn: conn, product: %Product{id: id} = product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.product_path(conn, :show, id))

      assert %{
               "id" => id,
               "product_category" => "some updated product_category",
               "product_id" => 43,
               "product_image" => "some updated product_image",
               "product_name" => "some updated product_name",
               "product_price" => "some updated product_price",
               "product_stock" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, Routes.product_path(conn, :delete, product))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.product_path(conn, :show, product))
      end
    end
  end

  defp create_product(_) do
    product = fixture(:product)
    %{product: product}
  end
end
