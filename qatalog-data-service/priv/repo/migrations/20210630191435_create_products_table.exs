defmodule QatalogData.Repo.Migrations.CreateProductsTable do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:products) do
      add :id, :id
      add :name, :string
      add :category, :string
      add :price, :decimal
      add :image, :string
      add :stock, :boolean

      timestamps()
    end

    create unique_index(:products, [:id], name: :id_must_be_unique)
  end
end
