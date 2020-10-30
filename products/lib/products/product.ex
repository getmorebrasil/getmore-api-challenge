defmodule Products.Product do
  @moduledoc """
  Defines the Product schema
  """

  use Ecto.Schema

  @derive {Jason.Encoder, except: [:__meta__]}

  @primary_key {:productId, :id, autogenerate: true}

  schema "products" do
    field :productCategory, :string
    field :productName, :string
    field :productImage, :string
    field :productStock, :boolean
    field :productPrice, :string
  end
end
