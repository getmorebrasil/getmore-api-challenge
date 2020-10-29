defmodule Products.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Products.Repo,
      Products.Product.Consumer
    ]

    opts = [strategy: :one_for_one, name: Products.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
