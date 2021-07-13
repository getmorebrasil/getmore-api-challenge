defmodule CatalogApiWeb.ProductsController do
  use CatalogApiWeb, :controller

  action_fallback CatalogApiWeb.FallbackController

  def index(conn, params) do
    with {:ok, params} <- validate_params(params),
         {:ok, result} <- CatalogApi.Usecases.GetProducts.call(params),
         {:ok, response} <- handle_response(result, params) do
      conn
      |> put_status(:ok)
      |> render("products.json", result: response)
    end
  end

  defp validate_params(params) do
    page_size = Map.get(params, "page_size", 10)
    current_page = Map.get(params, "current_page", 1)

    with {current_page, _} <- Integer.parse("#{current_page}", 10),
         {page_size, _} <- Integer.parse("#{page_size}", 10) do
      {:ok,
       %{
         "current_page" => current_page,
         "page_size" => page_size
       }}
    else
      :error -> {:error, %CatalogApi.Error{code: 400, detail: "invalid params"}}
    end
  end

  defp handle_response(%{"result" => products}, %{
         "page_size" => page_size,
         "current_page" => current_page
       }) do
    {:ok,
     %{
       "page_size" => page_size,
       "current_page" => current_page,
       "products" => products
     }}
  end

  defp handle_response(%{"result" => products}, %{
         "page_size" => page_size
       }) do
    {:ok,
     %{
       "page_size" => page_size,
       "current_page" => 1,
       "products" => products
     }}
  end

  defp handle_response(%{"result" => products}, %{}) do
    {:ok,
     %{
       "page_size" => length(products),
       "current_page" => 1,
       "products" => products
     }}
  end

  defp handle_response(%{"error" => error}, _params) do
    IO.inspect(error)
    {:error, "unexpected error"}
  end
end
