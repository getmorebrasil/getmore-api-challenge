defmodule ProductsData.Handler do
  alias ProductsData.Catalog

  def load_params(params) do
    {:ok, %{:page => _page, :page_size => _page_size} = params} = Poison.decode(params, keys: :atoms)
    params
  end

  def get_products(params) do
    Catalog.list_products(:paged, params.page, params.page_size)
  end

  def create_response(data) do
    Poison.encode(data)
  end
end
