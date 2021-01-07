defmodule Marketplace.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:product_id, :integer, autogenerate_id: true}

  schema "products" do
    field(:product_category, :string)
    field(:product_name, :string)
    field(:product_image, :string)
    field(:product_stock, :boolean)
    field(:product_price, :string)
    timestamps()
  end

  @required_params [
    :product_category,
    :product_name,
    :product_image,
    :product_stock,
    :product_price
  ]

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
