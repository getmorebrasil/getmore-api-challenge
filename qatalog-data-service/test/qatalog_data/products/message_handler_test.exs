defmodule QatalogData.Products.MessageHandlerTest do
  @moduledoc false

  use QatalogData.DataCase, async: true

  alias QatalogData.{Repo, Product}
  alias QatalogData.Products.MessageHandler

  describe "decode_payload/1" do
    test "when a valid JSON-format payload is given, returns a Tuple with an :ok and a Map" do

      response = "{\"message\": \"Hello\"}" |> MessageHandler.decode_payload()

      assert {:ok, %{"message" => "Hello"}} = response
    end

    test "when a invalid JSON-format payload is given, returns a Tuple with :error and the reason" do

      response = "{message: Hello}" |> MessageHandler.decode_payload()

      assert {:error, %Jason.DecodeError{data: "{message: Hello}", position: 1, token: nil}} = response
    end
  end

  describe "process_message/1" do
    test "when a Tuple with an :ok and a Map with 'id' key is given, returns a Product" do
      %{
        id: 1001,
        category: "Category 1",
        name: "Product 1",
        image: "https://picsum.photos/400?image=333",
        stock: true,
        price: Decimal.new("1871.425")
      }
      |> Product.changeset()
      |> Repo.insert()

      response = {:ok, %{"id" => "1001"}}
      |> MessageHandler.process_message()

      assert %Product{id: 1001} = response
    end

    test "when a Tuple with an :ok and a Map without 'id' key is given, returns a list of Products" do
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

      response = {:ok, %{}}
      |> MessageHandler.process_message()

      assert [%Product{}, %Product{}] = response
    end

    test "when a Tuple with an :error and a reason, returns an error" do

      response = {:error, "Oops, there was an error"}
      |> MessageHandler.process_message()

      assert %{error: "Oops! The given params are invalid"} = response
    end
  end

  describe "encode_response/1" do
    test "when a Map is given, returns a JSON" do

      response = %{"message" => "Hello"} |> MessageHandler.encode_response()

      assert "{\"message\":\"Hello\"}" = response
    end
  end
end
