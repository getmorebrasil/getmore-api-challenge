defmodule Products.ProductsDataTest do
  use Products.DataCase

  alias Products.ProductsData

  describe "products" do
    alias Products.ProductsData.Product

    @valid_attrs %{productCategory: "some productCategory", productId: 42, productImage: "some productImage", productName: "some productName", productPrice: "some productPrice", productStock: true}
    @update_attrs %{productCategory: "some updated productCategory", productId: 43, productImage: "some updated productImage", productName: "some updated productName", productPrice: "some updated productPrice", productStock: false}
    @invalid_attrs %{productCategory: nil, productId: nil, productImage: nil, productName: nil, productPrice: nil, productStock: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> ProductsData.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert ProductsData.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert ProductsData.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = ProductsData.create_product(@valid_attrs)
      assert product.productCategory == "some productCategory"
      assert product.productId == 42
      assert product.productImage == "some productImage"
      assert product.productName == "some productName"
      assert product.productPrice == "some productPrice"
      assert product.productStock == true
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductsData.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = ProductsData.update_product(product, @update_attrs)
      assert product.productCategory == "some updated productCategory"
      assert product.productId == 43
      assert product.productImage == "some updated productImage"
      assert product.productName == "some updated productName"
      assert product.productPrice == "some updated productPrice"
      assert product.productStock == false
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductsData.update_product(product, @invalid_attrs)
      assert product == ProductsData.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = ProductsData.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> ProductsData.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = ProductsData.change_product(product)
    end
  end
end
