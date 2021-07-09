defmodule Products.Release do
  @moduledoc """
  Handle migrations on a production environment
  """
  @app :products

  alias Ecto.Migrator

  @doc """
  Run ecto migration
  """
  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Migrator.with_repo(repo, &Migrator.run(&1, :up, all: true))
    end
  end

  @doc """
  Run ecto rollback
  """
  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Migrator.with_repo(repo, &Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
