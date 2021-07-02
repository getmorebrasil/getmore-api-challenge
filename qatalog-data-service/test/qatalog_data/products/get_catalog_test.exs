defmodule QatalogData.Products.GetCatalogTest do
  @moduledoc false

  use QatalogData.DataCase, async: true

  alias QatalogData.{Repo, Product}
  alias QatalogData.Products.GetCatalog

  describe "call/1" do
    test "when no params are given, returns a list of products" do
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

      response = GetCatalog.call(%{})

      assert [
               %Product{},
               %Product{}
             ] = response
    end

    test "when 'items' param is given, returns a page of products with the lenght equals to the value of 'items'" do
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

      response = GetCatalog.call(%{"items" => "1"})

      assert [%Product{}] = response
    end

    test "when 'page' and 'items' params are given, returns that page of products with the lenght equals to the value of 'items'" do
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

      response = GetCatalog.call(%{"items" => "1", "page" => "2"})

      assert [%Product{name: "Product 2"}] = response
    end

    test "when the param orderByPrice with the value 'asc' is given, returns a list of products in ascending price order" do
      products = [
        %{
          id: 1001,
          category: "Category 1",
          name: "Product 1",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("100")
        },
        %{
          id: 1002,
          category: "Category 2",
          name: "Product 2",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1")
        }
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetCatalog.call(%{"orderByPrice" => "asc"})

      assert [
               %Product{price: %Decimal{coef: 1, exp: 0, sign: 1}},
               %Product{price: %Decimal{coef: 100, exp: 0, sign: 1}}
             ] = response
    end

    test "when the param orderByPrice with the value 'desc' is given, returns a list of products in descending price order" do
      products = [
        %{
          id: 1001,
          category: "Category 1",
          name: "Product 1",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("100")
        },
        %{
          id: 1002,
          category: "Category 2",
          name: "Product 2",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1")
        }
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetCatalog.call(%{"orderByPrice" => "desc"})

      assert [
               %Product{price: %Decimal{coef: 100, exp: 0, sign: 1}},
               %Product{price: %Decimal{coef: 1, exp: 0, sign: 1}}
             ] = response
    end

    test "when the param inStock with the value 'true' is given, returns a list of products that are in stock" do
      products = [
        %{
          id: 1001,
          category: "Category 1",
          name: "Product 1",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("100")
        },
        %{
          id: 1002,
          category: "Category 2",
          name: "Product 2",
          image: "https://picsum.photos/400?image=333",
          stock: false,
          price: Decimal.new("1")
        }
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetCatalog.call(%{"inStock" => "true"})

      assert [%Product{stock: true}] = response
    end

    test "when the param inStock with the value 'false' is given, returns a list of products that aren't in stock" do
      products = [
        %{
          id: 1001,
          category: "Category 1",
          name: "Product 1",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("100")
        },
        %{
          id: 1002,
          category: "Category 2",
          name: "Product 2",
          image: "https://picsum.photos/400?image=333",
          stock: false,
          price: Decimal.new("1")
        }
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetCatalog.call(%{"inStock" => "false"})

      assert [%Product{stock: false}] = response
    end

    test "when the 'category' param is given, returns a list of products of that category" do
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

      response = GetCatalog.call(%{"category" => "Category 2"})

      assert [%Product{category: "Category 2"}] = response
    end

    test "when the 'page' param is given, returns a list of products of that page" do
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
        },
        %{
          id: 1003,
          category: "Category 1",
          name: "Product 3",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1004,
          category: "Category 2",
          name: "Product 4",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1005,
          category: "Category 1",
          name: "Product 5",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1006,
          category: "Category 2",
          name: "Product 6",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1007,
          category: "Category 1",
          name: "Product 7",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1008,
          category: "Category 2",
          name: "Product 8",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1009,
          category: "Category 2",
          name: "Product 9",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1010,
          category: "Category 1",
          name: "Product 10",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
        %{
          id: 1011,
          category: "Category 2",
          name: "Product 11",
          image: "https://picsum.photos/400?image=333",
          stock: true,
          price: Decimal.new("1871.425")
        },
      ]

      Enum.each(
        products,
        fn product ->
          product |> Product.changeset() |> Repo.insert!()
        end
      )

      response = GetCatalog.call(%{"page" => "2"})

      assert [%Product{}] = response
    end
  end
end
