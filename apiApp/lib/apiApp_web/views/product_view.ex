defmodule ApiAppWeb.ProductView do
  use ApiAppWeb, :view
  alias ApiAppWeb.ProductView

  def render("index.json", %{product: product}) do
    %{data: render_many(product, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      productId: product.productId,
      productCategory: product.productCategory,
      productName: product.productName,
      productImage: product.productImage,
      ProductStock: product.productStock,
      productPrice: product.productPrice}
  end
end
