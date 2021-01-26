# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ProductsAPI.Repo.insert!(%ProductsAPI.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ProductsData.Repo

json_seed = "priv/repo/seed/products.json"

with  {:ok, body} <- File.read(json_seed),
      {:ok, products} <- Poison.decode(body, as: [%ProductsData.Catalog.Product{}]) do
  Enum.each(products, fn(product) ->
    {price, _} =  Float.parse(product.productPrice)
    product = %{product | productPrice: price}

    Repo.insert!(product)
  end)
end
