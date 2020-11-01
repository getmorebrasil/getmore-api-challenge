defmodule ProductsWeb.ProductView do
  use ProductsWeb, :view

  def render("show-product.json", %{product: product}) do
    %{ data: render_one(product, __MODULE__, "product.json")}
  end

  def render("product.json", product) do
    %{id: product.product.id}
  end

  def render("products.json", %{products: products}) do

    Enum.map products, fn product -> %{
      productId: product.productId,
      productCategory: product.productCategory,
      productName: product.productName,
      productImage: product.productImage,
      productStock: product.productStock,
      productPrice: product.productPrice
      } end

  end

  def render("show-generic-resp.json", _) do
    %{}
  end

  def render("error.json", error) do
    IO.inspect error.error
    error.error
  end

end
