defmodule Marketplace.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:product_id, :integer, autogenerate_id: true}

  schema "products" do
    field :product_category, :string
    field :product_name, :string
    field :product_image, :string
    field :product_stock, :boolean
    field :product_price, :string
    timestamps()
  end
end
