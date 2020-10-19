defmodule GetmoreApiChallenge.Getmore.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(productId productCategory productName productImage productStock productPrice)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @derive {Jason.Encoder, only: @required}
  schema "products" do
    field :productCategory, :string
    field :productId, :integer
    field :productImage, :string
    field :productName, :string
    field :productPrice, :decimal
    field :productStock, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:productId, :productCategory, :productName, :productImage, :productStock, :productPrice])
    |> validate_required([:productId, :productCategory, :productName, :productImage, :productStock, :productPrice])
  end
end
