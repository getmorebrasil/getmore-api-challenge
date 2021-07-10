defmodule Products.Factory do
  @moduledoc """
  Factories to use on tests
  """
  use ExMachina.Ecto, repo: Products.Repo

  alias Products.Product

  def product_factory do
    %Product{
      category: "Category 1",
      image: "https://image.com",
      name: "Product Name",
      price: "40.00",
      stock: true
    }
  end
end
