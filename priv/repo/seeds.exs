# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Market.Repo.insert!(%Market.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Market.Shops.{Product}

require Logger

File.read!("priv/repo/products.json")
|> Jason.decode!()
|> Enum.map(
  &Map.new(&1, fn
    {"productId", val} ->
      {:id, val}

    {"productCategory", val} ->
      {:category, val}

    {"productName", val} ->
      {:name, val}

    {"productImage", val} ->
      {:image, val}

    {"productStock", val} ->
      {:stock, val}

    {"productPrice", val} ->
      {:price, Decimal.new(val)}

    {name, _val} ->
      Logger.error("Cant match #{inspect(name)}")
  end)
)
|> Enum.each(
  &(struct(Product, &1)
    |> Market.Repo.insert!())
)
