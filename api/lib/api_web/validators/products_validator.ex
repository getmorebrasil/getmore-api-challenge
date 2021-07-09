defmodule ApiWeb.ProductsValidator do
  @moduledoc """
  Validate products requests
  """
  import Ecto.Changeset

  alias Api.Error
  alias Ecto.Changeset

  @doc """
  validate index request
  """
  def index(params) do
    definition = %{page: :integer, page_size: :integer}

    case cast({%{}, definition}, params, Map.keys(definition)) do
      %Changeset{valid?: true, changes: changes} -> {:ok, changes}
      %Changeset{valid?: false} = changeset -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
