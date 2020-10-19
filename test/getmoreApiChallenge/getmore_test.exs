defmodule GetmoreApiChallenge.GetmoreTest do
  use GetmoreApiChallenge.DataCase

  alias GetmoreApiChallenge.Getmore

  describe "products" do
    alias GetmoreApiChallenge.Getmore.Product

    @valid_attrs %{productCategory: "some productCategory", productId: 42, productImage: "some productImage", productName: "some productName", productPrice: 120.5, productStock: true}
    @update_attrs %{productCategory: "some updated productCategory", productId: 43, productImage: "some updated productImage", productName: "some updated productName", productPrice: 456.7, productStock: false}
    @invalid_attrs %{productCategory: nil, productId: nil, productImage: nil, productName: nil, productPrice: nil, productStock: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Getmore.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Getmore.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Getmore.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Getmore.create_product(@valid_attrs)
      assert product.productCategory == "some productCategory"
      assert product.productId == 42
      assert product.productImage == "some productImage"
      assert product.productName == "some productName"
      assert product.productPrice == 120.5
      assert product.productStock == true
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Getmore.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Getmore.update_product(product, @update_attrs)
      assert product.productCategory == "some updated productCategory"
      assert product.productId == 43
      assert product.productImage == "some updated productImage"
      assert product.productName == "some updated productName"
      assert product.productPrice == 456.7
      assert product.productStock == false
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Getmore.update_product(product, @invalid_attrs)
      assert product == Getmore.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Getmore.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Getmore.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Getmore.change_product(product)
    end
  end

  describe "products" do
    alias GetmoreApiChallenge.Getmore.Product

    @valid_attrs %{productCategory: "some productCategory", productId: 42, productImage: "some productImage", productName: "some productName", productPrice: "120.5", productStock: true}
    @update_attrs %{productCategory: "some updated productCategory", productId: 43, productImage: "some updated productImage", productName: "some updated productName", productPrice: "456.7", productStock: false}
    @invalid_attrs %{productCategory: nil, productId: nil, productImage: nil, productName: nil, productPrice: nil, productStock: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Getmore.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Getmore.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Getmore.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Getmore.create_product(@valid_attrs)
      assert product.productCategory == "some productCategory"
      assert product.productId == 42
      assert product.productImage == "some productImage"
      assert product.productName == "some productName"
      assert product.productPrice == Decimal.new("120.5")
      assert product.productStock == true
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Getmore.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Getmore.update_product(product, @update_attrs)
      assert product.productCategory == "some updated productCategory"
      assert product.productId == 43
      assert product.productImage == "some updated productImage"
      assert product.productName == "some updated productName"
      assert product.productPrice == Decimal.new("456.7")
      assert product.productStock == false
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Getmore.update_product(product, @invalid_attrs)
      assert product == Getmore.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Getmore.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Getmore.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Getmore.change_product(product)
    end
  end
end
