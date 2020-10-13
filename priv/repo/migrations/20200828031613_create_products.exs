defmodule Market.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :image, :string
      add :stock, :boolean
      add :price, :decimal 
      add :category, :string

      timestamps()
    end
  end
end
