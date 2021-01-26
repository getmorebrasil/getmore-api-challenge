defmodule ProductsData.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :productId, :id, primary_key: true
      add :productCategory, :string
      add :productName, :string, null: false
      add :productImage, :string
      add :productStock, :boolean, default: false
      add :productPrice, :decimal

      timestamps()
    end
  end
end
