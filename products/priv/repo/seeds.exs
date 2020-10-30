json_path = "#{__DIR__}/products.json"

with {:ok, body} <- File.read(json_path),
     {:ok, json} <- Jason.decode(body, keys: :atoms) do
      Products.Repo.insert_all(Products.Product, json)
else
  err ->
      IO.inspect(err)
end
