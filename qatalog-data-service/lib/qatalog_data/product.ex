defmodule QatalogData.Product do
  @moduledoc """
    QatalogData.Product provides a function to get the Product entity changeset
  """

  use Ecto.Schema

  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__, :__struct__, :uuid]}
  @primary_key {:uuid, :binary_id, autogenerate: true}
  @fields [:id, :category, :name, :image, :stock, :price]

  schema "products" do
    field(:id, :id)
    field(:category, :string)
    field(:name, :string)
    field(:image, :string)
    field(:stock, :boolean)
    field(:price, :decimal)

    timestamps()
  end

  @doc """
    Creates an Ecto changeset of Product when the required params are given

    ## Parameters
    - params: Map containing the parameters to create an Ecto changeset

    ## Examples

      \tiex> required_params = %{...}
      \tiex> required_params |> Product.changeset()
      \t%Ecto.Changeset{\f
        \tvalid?: true,\f
        \terrors: [],\f
        \tchanges: %{...}
      \t}
  """
  @spec changeset(Map.t()) :: Ecto.Changeset.t()
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_number(:price, greater_than: 0)
    |> unique_constraint(:id, name: :id_must_be_unique)
  end
end
