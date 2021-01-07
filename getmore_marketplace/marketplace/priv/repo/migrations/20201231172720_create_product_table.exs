defmodule Marketplace.Repo.Migrations.CreateProductTable do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add(:product_id, :integer, primary_key: true)
      add(:product_category, :string)
      add(:product_name, :string)
      add(:product_image, :string)
      add(:product_stock, :boolean)
      add(:product_price, :string)
      timestamps()
    end
  end
end
