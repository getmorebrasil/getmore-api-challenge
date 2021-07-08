defmodule Products.DataCase do
  @moduledoc """
  Test case to use database
  """
  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias Products.Repo

      import Ecto
      import Ecto.Query
      import Products.DataCase
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Products.Repo)

    unless tags[:async] do
      Sandbox.mode(Products.Repo, {:shared, self()})
    end

    :ok
  end
end
