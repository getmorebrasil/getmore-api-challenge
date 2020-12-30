defmodule Marketplace do
  alias Marketplace.Product

  defdelegate index_product(params), to: Product.Index, as: :call
end
