defmodule Products.MixProject do
  use Mix.Project

  def project do
    [
      app: :products,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Products.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.5.3"},
      {:postgrex, ">= 0.15.7"},
      {:credo, "~> 1.5.0-rc.2", only: [:dev, :test], runtime: false},
      {:amqp, "~> 1.6.0"}
    ]
  end
end
