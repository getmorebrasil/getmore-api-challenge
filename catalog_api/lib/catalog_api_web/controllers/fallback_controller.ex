defmodule CatalogApiWeb.FallbackController do
  use CatalogApiWeb, :controller

  alias CatalogApiWeb.ErrorView

  def call(conn, {:error, %CatalogApi.Error{} = error}) do
    conn
    |> put_status(error.code)
    |> put_view(ErrorView)
    |> render("#{error.code}.json", error: error)
  end

  def call(conn, {:error, error}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(ErrorView)
    |> render("500.json", error: error)
  end
end
