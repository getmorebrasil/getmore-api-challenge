# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GetmoreApi.Repo.insert!(%GetmoreApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GetmoreApi.Repo
alias GetmoreApi.Store.Product

Repo.delete_all(Product)

with {:ok, result} <- File.read("products.json"),
     {:ok, products} <- Jason.decode(result) do
  Enum.map(products, fn map ->
    {product_price, _} = Float.parse(map["productPrice"])

    product =
      Enum.into(map, %{}, fn {k, v} -> {k |> Macro.underscore() |> String.to_atom(), v} end)

    product =
      Product
      |> struct(%{product | product_price: product_price})

    Repo.insert!(product)
  end)
end
