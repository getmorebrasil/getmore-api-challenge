defmodule Marketplace.Product.IndexTest do
  use ExUnit.Case

  alias Marketplace.Product

  describe "index/1" do
    test "return list of products" do
      params = %{page: 1, page_size: 3}

      expected_response = [
        %{
          product_category: "Category 2",
          product_id: 1001,
          product_image: "https://picsum.photos/400?image=333",
          product_name: "Product 1",
          product_price: "1871.425",
          product_stock: true
        },
        %{
          product_category: "Category 2",
          product_id: 1002,
          product_image: "https://picsum.photos/400?image=516",
          product_name: "Product 2",
          product_price: "3874.773",
          product_stock: false
        },
        %{
          product_category: "Category 3",
          product_id: 1003,
          product_image: "https://picsum.photos/400?image=949",
          product_name: "Product 3",
          product_price: "1145.060",
          product_stock: false
        }
      ]

      assert expected_response == Product.Index.call(params)
    end
  end
end
