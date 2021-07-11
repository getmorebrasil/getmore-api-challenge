defmodule Catalog.Schemas.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:product_id, :integer, autogenerate_id: true}

  @required_fields [
    :product_category,
    :product_name,
    :product_image,
    :product_stock,
    :product_price
  ]

  schema "products" do
    field :product_category, :string
    field :product_name, :string
    field :product_image, :string
    field :product_stock, :boolean
    field :product_price, :decimal

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
