defmodule GetmoreApi.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :product_id, :id, primary_key: true
      add :product_category, :string
      add :product_name, :string
      add :product_image, :string
      add :product_stock, :boolean, default: false, null: false
      add :product_price, :float
    end
  end
end
