defmodule QatalogApiWeb.FallbackController do
  use QatalogApiWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(QatalogApiWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
