defmodule QatalogData.ProductTest do
  @moduledoc false

  use QatalogData.DataCase, async: true
  alias QatalogData.Product

  describe "changeset/1" do
    test "when all valid params are given, returns a product" do
      price = Decimal.new("1145.773")

      params = %{
        id: 1,
        category: "Category 1",
        name: "Product 1",
        image: "https://picsum.photos/400?image=333",
        stock: true,
        price: price
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
               valid?: true,
               errors: [],
               changes: %{
                 category: "Category 1",
                 name: "Product 1",
                 image: "https://picsum.photos/400?image=333",
                 stock: true,
                 price: ^price
               }
             } = response
    end

    test "when no category is given, returns an error" do
      price = Decimal.new("1145.773")

      params = %{
        id: 1,
        name: "Product 1",
        image: "https://picsum.photos/400?image=333",
        stock: true,
        price: price
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
               valid?: false,
               errors: [{:category, {"can't be blank", [validation: :required]}}],
               changes: _changes
             } = response
    end

    test "when no id is given, returns an error" do
      price = Decimal.new("1145.773")

      params = %{
        name: "Product 1",
        category: "Category 1",
        image: "https://picsum.photos/400?image=333",
        stock: true,
        price: price
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
               valid?: false,
               errors: [{:id, {"can't be blank", [validation: :required]}}],
               changes: _changes
             } = response
    end

    test "when no name is given, returns an error" do
      price = Decimal.new("1145.773")

      params = %{
        id: 1,
        category: "Category 1",
        image: "https://picsum.photos/400?image=333",
        stock: true,
        price: price
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
               valid?: false,
               errors: [{:name, {"can't be blank", [validation: :required]}}],
               changes: _changes
             } = response
    end

    test "when no image is given, returns a product" do
      price = Decimal.new("1145.773")

      params = %{
        id: 1,
        category: "Category 1",
        name: "Product 1",
        stock: true,
        price: price
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
        valid?: false,
        errors: [image: {"can't be blank", [validation: :required]}],
        changes: _changes
      } = response
    end

    test "when no stock is given, returns a product" do
      price = Decimal.new("1145.773")

      params = %{
        id: 1,
        category: "Category 1",
        name: "Product 1",
        image: "https://picsum.photos/400?image=333",
        price: price
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
        valid?: false,
        errors: [stock: {"can't be blank", [validation: :required]}],
        changes: _changes
      } = response
    end


    test "when no price is given, returns a product" do
      params = %{
        id: 1,
        category: "Category 1",
        name: "Product 1",
        image: "https://picsum.photos/400?image=333",
        stock: true,
      }

      response = params |> Product.changeset()

      assert %Ecto.Changeset{
        valid?: false,
        errors: [price: {"can't be blank", [validation: :required]}],
        changes: _changes
      } = response
    end
  end
end
