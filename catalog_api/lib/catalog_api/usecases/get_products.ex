defmodule CatalogApi.Usecases.GetProducts do
  alias CatalogApi.RPC

  def call(params) do
    RPC.call("products_exchange", "get", params)
  end
end
