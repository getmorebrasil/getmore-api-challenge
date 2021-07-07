defmodule ApiApp.Schema.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product" do
    field :ProductStock, :boolean, default: false
    field :productCategory, :string
    field :productId, :integer
    field :productImage, :string
    field :productName, :string
    field :productPrice, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:productId, :productCategory, :productName, :productImage, :ProductStock, :productPrice])
    |> validate_required([:productId, :productCategory, :productName, :productImage, :ProductStock, :productPrice])
  end
end
