defmodule GetmoreApi.Paginator do
  import Ecto.Query
  alias GetmoreApi.Repo

  defstruct [:entries, :page_number, :page_size, :total_pages]

  def new(query, params) do
    page_number = params |> Map.get("page", 1) |> to_int
    page_size = params |> Map.get("page_size", 10) |> to_int

    %__MODULE__{
      entries: entries(query, page_number, page_size),
      page_number: page_number,
      total_pages: total_pages(query, page_size)
    }
  end

  defp ceiling(float) do
    t = trunc(float)

    case float - t do
      neg when neg < 0 -> t
      pos when pos > 0 -> t + 1
      _ -> t
    end
  end

  defp entries(query, page_number, page_size) do
    offset = page_size * (page_number - 1)

    query
    |> limit(^page_size)
    |> offset(^offset)
    |> Repo.all()
  end

  defp to_int(i) when is_integer(i), do: i

  defp to_int(s) when is_binary(s) do
    case Integer.parse(s) do
      {i, _} -> i
      :error -> :error
    end
  end

  defp total_pages(query, page_size) do
    count =
      query
      |> exclude(:order_by)
      |> exclude(:preload)
      |> exclude(:select)
      |> select([e], count(e.product_id))
      |> Repo.one()

    ceiling(count / page_size)
  end
end
