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

#  mix run priv/repo/seeds.exs
