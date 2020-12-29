alias Marketplace.{Repo, Product}

json_file = "#{__DIR__}/seeds/products.json"

with {:ok, body} <- File.read(json_file),
     {:ok, json} <- Jason.decode(body, keys: :strings) do
  products =
    Enum.map(json, fn product ->
      Enum.reduce(product, %{}, fn {key, value}, acc ->
        Map.put(acc, String.to_atom(Macro.underscore(key)), value)
      end)
    end)

  Repo.insert_all(Product, products, timestamps: true)
else
  err ->
    Repo.delete_all(Product)
    IO.inspect(err)
end

# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Marketplace.Repo.insert!(%Marketplace.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
