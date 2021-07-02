defmodule QatalogApiWeb.ProductsController do
  @moduledoc false

  use QatalogApiWeb, :controller

  action_fallback QatalogApiWeb.FallbackController

  def get_catalog(conn, params) do
    response = QatalogApi.get_catalog(params)

    conn
    |> put_status(:ok)
    |> json(response)
  end

  def get_product(conn, params) do
    response = QatalogApi.get_product(params)

    conn
    |> put_status(:ok)
    |> json(response)
  end
end
