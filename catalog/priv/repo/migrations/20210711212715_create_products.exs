defmodule Catalog.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table :products, primary_key: false do
      add :product_id, :integer, primary_key: true
      add :product_category, :string, null: false
      add :product_name, :string, null: false
      add :product_image, :string, null: false
      add :product_stock, :boolean, null: false
      add :product_price, :decimal, null: false

      timestamps()
    end
  end
end
