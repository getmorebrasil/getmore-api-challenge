defmodule Products.Product do
  @moduledoc """
  Defines the Product schema
  """

  use Ecto.Schema

  @primary_key {:productId, :id, autogenerate: true}

  schema "products" do
    field :productCategory, :string
    field :productName, :string
    field :productImage, :string
    field :productStock, :boolean
    field :productPrice, :float
  end
end
