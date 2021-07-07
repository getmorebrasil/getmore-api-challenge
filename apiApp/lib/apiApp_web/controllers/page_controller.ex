defmodule ApiAppWeb.PageController do
  use ApiAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
