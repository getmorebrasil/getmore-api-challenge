defmodule ProductsData.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:productId, :id, autogenerate: true}
  @foreign_key_type :id
  schema "products" do
    field :productCategory, :string
    field :productName, :string, null: false
    field :productImage, :string
    field :productStock, :boolean, default: false
    field :productPrice, :decimal

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:productName])
    |> validate_required([:productName])
  end
end
