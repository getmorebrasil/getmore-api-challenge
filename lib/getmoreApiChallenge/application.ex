defmodule GetmoreApiChallenge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GetmoreApiChallenge.Repo,
      # Start the Telemetry supervisor
      GetmoreApiChallengeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GetmoreApiChallenge.PubSub},
      # Start the Endpoint (http/https)
      GetmoreApiChallengeWeb.Endpoint,
      # Start a worker by calling: GetmoreApiChallenge.Worker.start_link(arg)
      # {GetmoreApiChallenge.Worker, arg}


      #RPX.AMQP.Server,
      #GetmoreApiChallenge.RPX.Server
      {GetmoreApiChallenge.RPX.Server,
          worker: GetmoreApiChallenge.Getmore,
          queue_name: "products"},

      # RabitMQ client
      RPX.AMQP.Client,


      #RPX.AMPQ.Connection,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GetmoreApiChallenge.Supervisor]
    #opts = [strategy: :one_for_one, name: Test.Supervisor]
    #Supervisor.init([], strategy: :simple_one_for_one)
    Supervisor.start_link(children, opts)

  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GetmoreApiChallengeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
