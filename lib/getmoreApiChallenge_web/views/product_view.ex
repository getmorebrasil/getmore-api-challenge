defmodule GetmoreApiChallengeWeb.ProductView do
  use GetmoreApiChallengeWeb, :view
  alias GetmoreApiChallengeWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
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
      productStock: product.productStock,
      productPrice: product.productPrice}
  end
end
