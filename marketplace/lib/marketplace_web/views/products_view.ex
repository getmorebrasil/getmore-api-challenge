defmodule MarketplaceWeb.ProductsView do
  use MarketplaceWeb, :view

  def render("index.json", %{products: products}) do
    %{
      products: convert_strutcts_to_map(products)
    }
  end

  defp convert_strutcts_to_map(structs) do
    Enum.map(structs, fn product ->
      product
      |> Map.from_struct()
      |> Map.delete(:__meta__)
      |> Map.delete(:inserted_at)
      |> Map.delete(:updated_at)
    end)
  end
end
