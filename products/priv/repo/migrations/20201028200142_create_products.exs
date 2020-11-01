defmodule Products.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :productId, :integer
      add :productCategory, :string
      add :productName, :string
      add :productImage, :string
      add :productStock, :boolean, default: false, null: false
      add :productPrice, :string

      timestamps()
    end

  end
end
