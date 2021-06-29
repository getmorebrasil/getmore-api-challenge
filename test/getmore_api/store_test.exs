defmodule GetmoreApi.StoreTest do
  use GetmoreApi.DataCase

  alias GetmoreApi.Store

  describe "products" do
    alias GetmoreApi.Store.Product

    @valid_attrs %{
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

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Store.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Store.list_products() == [product]
    end
  end
end
