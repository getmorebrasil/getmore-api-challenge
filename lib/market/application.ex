defmodule Market.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Market.Repo,
      # RabitMQ client
      {Market.RpxFixes.Server, worker: Market.Shops, queue_name: "shops"},
      RPX.AMQP.Client
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Market.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
