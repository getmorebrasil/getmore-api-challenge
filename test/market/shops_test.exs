defmodule Market.ShopsTest do
  use Market.DataCase

  alias Market.Shops

  describe "products" do
    alias Market.Shops.Product

    @valid_attrs %{name: "some name", image: "https://picsum.photos/400?image=333", stock: true, price: Decimal.new("1871.425"), category: "some category"}
    @invalid_attrs %{name: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Shops.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Shops.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Shops.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Shops.create_product(@valid_attrs)
      assert product.name == "some name"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Shops.create_product(@invalid_attrs)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Shops.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Shops.get_product!(product.id) end
    end
  end
end
