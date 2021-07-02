defmodule QatalogData.Products.GetProductTest do
  @moduledoc false

  use QatalogData.DataCase, async: true

  alias QatalogData.{Repo, Product}
  alias QatalogData.Products.GetProduct

  describe "call/1" do
    test "when a valid id is given, returns a Product" do
      products = [
        %{
          id: 1001,
          category: "Category 1",
          name: "Product 1",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1002,
          category: "Category 2",
          name: "Product 2",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        }
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetProduct.call(1001)

      assert %Product{id: 1001} = response
    end

    test "when a non-existing id is given, returns an error" do
            products = [
        %{
          id: 1001,
          category: "Category 1",
          name: "Product 1",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1002,
          category: "Category 2",
          name: "Product 2",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        }
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetProduct.call(1003)

      assert %{error: "Oops! No products were found with the id 1003"} = response
    end
  end
end
