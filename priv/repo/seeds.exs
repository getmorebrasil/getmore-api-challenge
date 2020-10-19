# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GetmoreApiChallenge.Repo.insert!(%GetmoreApiChallenge.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias GetmoreApiChallenge.Getmore.{Product}

require Logger

File.read!("priv/repo/json/products.json")
|> Jason.decode!()
|> Enum.map(
  &Map.new(&1, fn
    {"productId", val} ->
      {:productId, val}

    {"productCategory", val} ->
      {:productCategory, val}

    {"productName", val} ->
      {:productName, val}

    {"productImage", val} ->
      {:productImage, val}

    {"productStock", val} ->
      {:productStock, val}

    {"productPrice", val} ->
      {:productPrice, Decimal.new(val)}

    {name, _val} ->
      Logger.error("ERROR : Cant match #{inspect(name)}")
  end)
)
|> Enum.each(
  &(struct(Product, &1)
    |> GetmoreApiChallenge.Repo.insert!())
)
