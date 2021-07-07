# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApiApp.Repo.insert!(%ApiApp.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seed do
  alias ApiApp.Repo
  alias ApiApp.Schema.Product

  def insert_products do
    entries = read_json("products.json")
    Repo.insert_all(Product, entries)
  end

  def delete_products do
    Repo.delete_all(Product)
  end

  defp read_json(filename) do
    File.read!(filename)
    |> Jason.decode!()
    |> Enum.map(fn map ->
      Enum.into(map, %{}, fn {k, v} -> {String.to_atom(Macro.underscore(k)), v} end)
    end)
  end
end

Seed.delete_products()
Seed.insert_products()
