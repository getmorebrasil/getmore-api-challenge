defmodule ApiApp.SchemaTest do
  use ApiApp.DataCase

  alias ApiApp.Schema

  describe "product" do
    alias ApiApp.Schema.Product

    @valid_attrs %{ProductStock: true, productCategory: "some productCategory", productId: 42, productImage: "some productImage", productName: "some productName", productPrice: "some productPrice"}
    @update_attrs %{ProductStock: false, productCategory: "some updated productCategory", productId: 43, productImage: "some updated productImage", productName: "some updated productName", productPrice: "some updated productPrice"}
    @invalid_attrs %{ProductStock: nil, productCategory: nil, productId: nil, productImage: nil, productName: nil, productPrice: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_product()

      product
    end

    test "list_product/0 returns all product" do
      product = product_fixture()
      assert Schema.list_product() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Schema.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Schema.create_product(@valid_attrs)
      assert product.ProductStock == true
      assert product.productCategory == "some productCategory"
      assert product.productId == 42
      assert product.productImage == "some productImage"
      assert product.productName == "some productName"
      assert product.productPrice == "some productPrice"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Schema.update_product(product, @update_attrs)
      assert product.ProductStock == false
      assert product.productCategory == "some updated productCategory"
      assert product.productId == 43
      assert product.productImage == "some updated productImage"
      assert product.productName == "some updated productName"
      assert product.productPrice == "some updated productPrice"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_product(product, @invalid_attrs)
      assert product == Schema.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Schema.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Schema.change_product(product)
    end
  end
end
