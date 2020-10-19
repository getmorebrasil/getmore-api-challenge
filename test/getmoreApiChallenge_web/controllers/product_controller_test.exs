defmodule GetmoreApiChallengeWeb.ProductControllerTest do
  use GetmoreApiChallengeWeb.ConnCase

  alias GetmoreApiChallenge.Getmore
  alias GetmoreApiChallenge.Getmore.Product

  @create_attrs %{
    productCategory: "some productCategory",
    productId: 42,
    productImage: "some productImage",
    productName: "some productName",
    productPrice: "120.5",
    productStock: true
  }
  @update_attrs %{
    productCategory: "some updated productCategory",
    productId: 43,
    productImage: "some updated productImage",
    productName: "some updated productName",
    productPrice: "456.7",
    productStock: false
  }
  @invalid_attrs %{productCategory: nil, productId: nil, productImage: nil, productName: nil, productPrice: nil, productStock: nil}

  def fixture(:product) do
    {:ok, product} = Getmore.create_product(@create_attrs)
    product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all products", %{conn: conn} do
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
               "productCategory" => "some productCategory",
               "productId" => 42,
               "productImage" => "some productImage",
               "productName" => "some productName",
               "productPrice" => "120.5",
               "productStock" => true
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
               "productCategory" => "some updated productCategory",
               "productId" => 43,
               "productImage" => "some updated productImage",
               "productName" => "some updated productName",
               "productPrice" => "456.7",
               "productStock" => false
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
