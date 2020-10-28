defmodule Products.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :productId, :id, primary_key: true
      add :productCategory, :string, null: false
      add :productName, :string, null: false
      add :productImage, :string, null: false
      add :productStock, :boolean, null: false
      add :productPrice, :float, null: false
    end
  end
end
