defmodule QatalogData.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      QatalogData.Repo,
      # Start the Telemetry supervisor
      QatalogDataWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: QatalogData.PubSub},
      # Start the Endpoint (http/https)
      QatalogDataWeb.Endpoint,
      # Start a worker by calling: QatalogData.Worker.start_link(arg)
      # {QatalogData.Worker, arg}
      QatalogData.Products.Consumer
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QatalogData.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QatalogDataWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
