defmodule CatalogApiWeb.ProductsView do
  def render("products.json", %{result: result}) do
    %{result: result}
  end
end
