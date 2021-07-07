defmodule ApiApp.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :productId, :integer
      add :productCategory, :string
      add :productName, :string
      add :productImage, :string
      add :ProductStock, :boolean, default: false, null: false
      add :productPrice, :string

      timestamps()
    end

  end
end
