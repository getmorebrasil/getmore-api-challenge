defmodule GetmoreApiWeb.ProductView do
  use GetmoreApiWeb, :view

  def render("index.json", %{data: data}) do
    data
  end
end
