defmodule GetmoreApiChallenge.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :productId, :integer
      add :productCategory, :string
      add :productName, :string
      add :productImage, :string
      add :productStock, :boolean, default: false, null: false
      add :productPrice, :decimal

      timestamps()
    end

  end
end
