defmodule ApiWeb.ProductsView do
  use ApiWeb, :view

  def render("products.json", %{products: products}), do: %{products: products}
end
