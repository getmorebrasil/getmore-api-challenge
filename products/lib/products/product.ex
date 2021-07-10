defmodule Products.Product do
  @moduledoc """
  Product schema to represent products table
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @required_params [:category, :name, :image, :price]
  @cast_params [:stock | @required_params]

  @derive {Jason.Encoder,
           only: [
             :id,
             :category,
             :image,
             :inserted_at,
             :name,
             :price,
             :stock,
             :updated_at
           ]}

  @typedoc """
  Product definition
  """
  @type t :: %__MODULE__{
          category: String.t(),
          image: String.t(),
          inserted_at: NaiveDateTime.t(),
          name: String.t(),
          price: Decimal.t(),
          stock: boolean(),
          updated_at: NaiveDateTime.t()
        }

  schema "products" do
    field :category, :string
    field :image, :string
    field :name, :string
    field :price, :decimal
    field :stock, :boolean, default: true

    timestamps()
  end

  @spec changeset(map()) :: Changeset.t()
  @spec changeset(t(), map()) :: Changeset.t()
  @doc """
  Cast params to struct and handle validations
  """
  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @cast_params)
    |> validate_required(@required_params)
  end
end
