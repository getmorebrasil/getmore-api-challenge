defmodule GetmoreApi.Store.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [
    :product_id,
    :product_category,
    :product_name,
    :product_image,
    :product_stock,
    :product_price
  ]

  schema "products" do
    field :product_category, :string
    field :product_id, :integer
    field :product_image, :string
    field :product_name, :string
    field :product_price, :float
    field :product_stock, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
