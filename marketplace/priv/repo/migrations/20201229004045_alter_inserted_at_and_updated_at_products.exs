defmodule Marketplace.Repo.Migrations.AlterInsertedAtAndUpdatedAtProducts do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :inserted_at, :utc_datetime, default: fragment("NOW()")
      modify :updated_at, :utc_datetime, default: fragment("NOW()")
    end
  end
end
