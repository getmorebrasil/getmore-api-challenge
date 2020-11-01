defmodule Products.ProductsData.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :productCategory, :string
    field :productId, :integer
    field :productImage, :string
    field :productName, :string
    field :productPrice, :string
    field :productStock, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:productId, :productCategory, :productName, :productImage, :productStock, :productPrice])
    |> validate_required([:productId, :productCategory, :productName, :productImage, :productStock, :productPrice])
  end

  @doc false
  def changesets(%{"_json" => products}) do
    products
    |> Enum.map(fn product -> for {key, val} <- product, into: %{}, do: {String.to_atom(key), val} end)
    |> Enum.map(fn product ->
      product
      |> Map.put(:inserted_at, NaiveDateTime.local_now())
      |> Map.put(:updated_at, NaiveDateTime.local_now())
    end)
  end
end
