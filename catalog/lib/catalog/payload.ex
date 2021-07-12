defmodule Catalog.Payload do
  def parse(payload, "application/json") do
    Jason.decode(payload)
    |> parse_params()
  end

  def parse(_payload, :undefined),
    do: {:error, "content_type not specified"}

  def parse(_payload, _), do: {:error, "invalid content_type"}

  defp parse_params({:ok, %{"current_page" => current_page, "page_size" => page_size}}) do
    with {current_page, _} <- Integer.parse("#{current_page}", 10),
         {page_size, _} <- Integer.parse("#{page_size}", 10) do
      {:ok,
       %{
         "current_page" => current_page,
         "page_size" => page_size
       }}
    else
      :error ->
        {:error, "invalid params"}
    end
  end

  defp parse_params({:ok, %{"page_size" => page_size}}) do
    with {page_size, _} <- Integer.parse("#{page_size}", 10) do
      {:ok,
       %{
         "current_page" => 1,
         "page_size" => page_size
       }}
    else
      :error -> {:error, "invalid params"}
    end
  end

  defp parse_params({:ok, %{}}), do: {:ok, :all}

  defp parse_params({:error, _}) do
    {:error, "invalid params"}
  end
end
