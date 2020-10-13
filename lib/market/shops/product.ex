defmodule Market.Shops.Product do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w[name image stock price category]a

  @derive {Jason.Encoder, only: @required}
  schema "products" do
    field :name, :string
    field :image, :string
    field :stock, :boolean
    field :category, :string
    field :price, :decimal

    timestamps()
  end

  @doc false
  def changeset(bottler, attrs) do
    bottler
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
