Path.join(["..", "products.json"])
|> File.read!()
|> Jason.decode!()
|> Enum.map(fn product -> %{
  id: product["productId"],
  category: product["productCategory"],
  image: product["productImage"],
  name: product["productName"],
  price: Decimal.new(product["productPrice"]),
  stock: product["productStock"],
  inserted_at: %{NaiveDateTime.utc_now() | microsecond: {0, 0}},
  updated_at: %{NaiveDateTime.utc_now() | microsecond: {0, 0}}
} end)
|> then(&Products.Repo.insert_all(Products.Product, &1))
