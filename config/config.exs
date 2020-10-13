# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :market,
  ecto_repos: [Market.Repo],
  user_salt: "user_salt"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :rpx, RPX.AMQP.Client,
  host: "amqp://localhost:5672"

config :rpx, RPX.AMQP.Server,
  host: "amqp://localhost:5672"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
