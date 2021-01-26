defmodule ProductsData.MixProject do
  use Mix.Project

  def project do
    [
      app: :products_data,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ProductsData.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:poison, "~> 3.1"},
      {:amqp, "~> 2.0.0-rc.2"}
    ]
  end
end
