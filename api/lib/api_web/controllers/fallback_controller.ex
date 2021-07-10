defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  alias Api.Error
  alias ApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, content: content}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", content: content)
  end
end
