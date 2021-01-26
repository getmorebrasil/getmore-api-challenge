defmodule ProductsAPIWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ProductsAPIWeb, :controller

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ProductsAPIWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :required_params, params}) do
    conn
    |> put_status(400)
    |> text("Error, missing required params: #{params}")
  end
end
