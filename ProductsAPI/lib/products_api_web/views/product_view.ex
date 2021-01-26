defmodule ProductsAPIWeb.ProductView do
  use ProductsAPIWeb, :view
  alias ProductsAPIWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      productName: product.productName,
      productCategory: product.productCategory,
      productImage: product.productImage,
      productStock: product.productStock,
      productPrice: product.productPrice}
  end

  def render("list.json", %{list: data}) do
    data
  end
end
