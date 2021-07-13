defmodule Catalog.Repo.Seeds.Products do
  alias Catalog.Repo
  alias Catalog.Schemas.Product

  def run do
    System.argv
    |> parse_path()
    |> parse_file()
    |> handle_products()
    |> seed_all()
  end

  defp parse_path([filename]) do
    "#{File.cwd!}/#{filename}"
  end

  defp parse_file(path) do
    path
    |> File.read!()
    |> Jason.decode!()
  end

  defp handle_products(products) do
    products
    |> Enum.map(&parse_product/1)
  end

  defp parse_product(product) do
    product
    |> Enum.reduce(%{}, fn {key, value}, new_product ->
      new_product
      |> Map.put(String.to_atom(Macro.underscore(key)), value)
    end)
    |> cast_price()
    |> put_timestamps()
  end

  defp cast_price(%{product_price: price} = product) do
    %{product | product_price: Decimal.new(price)}
  end

  defp put_timestamps(product) do
    now =
      NaiveDateTime.utc_now
      |> NaiveDateTime.truncate(:second)

    product
    |> Map.put(:inserted_at, now)
    |> Map.put(:updated_at, now)
  end

  defp seed_all(products) do
    Repo.insert_all(Product, products)
  end
end

Catalog.Repo.Seeds.Products.run
