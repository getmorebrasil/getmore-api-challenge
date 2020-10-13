defmodule Market.RpxTest do
  use Market.DataCase, async: false

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
      result = RPX.AMQP.Client.call("shops", "list_products", []) |> Task.await
      assert result == [%{"category" => "some category", "image" => "https://picsum.photos/400?image=333", "name" => "some name", "price" => "1871.425", "stock" => true}]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      result = RPX.AMQP.Client.call("shops", "get_product!", [product.id]) |> Task.await
      assert result == %{"category" => "some category", "image" => "https://picsum.photos/400?image=333", "name" => "some name", "price" => "1871.425", "stock" => true}
    end
  end
end
