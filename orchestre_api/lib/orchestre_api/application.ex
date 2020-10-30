defmodule OrchestreApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      OrchestreApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: OrchestreApi.PubSub},
      # Start the Endpoint (http/https)
      OrchestreApiWeb.Endpoint
      # Start a worker by calling: OrchestreApi.Worker.start_link(arg)
      # {OrchestreApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OrchestreApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    OrchestreApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
