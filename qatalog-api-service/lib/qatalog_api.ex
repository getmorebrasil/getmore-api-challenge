defmodule QatalogApi do
  @moduledoc """
  QatalogApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias QatalogApi.Products.Publisher, as: ProductsPublisher

  defdelegate get_catalog(params), to: ProductsPublisher, as: :publish_message
  defdelegate get_product(params), to: ProductsPublisher, as: :publish_message
end
