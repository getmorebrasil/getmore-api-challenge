defmodule Products.Repo.Migrations.CreateProductsTable do
  @moduledoc """
  Create products table
  """
  use Ecto.Migration

  def change do
    create table(:products) do
      add :category, :string
      add :image, :string
      add :name, :string
      add :price, :decimal
      add :stock, :boolean, default: false

      timestamps()
    end
  end
end
