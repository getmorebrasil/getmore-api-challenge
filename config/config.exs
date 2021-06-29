# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :getmore_api,
  ecto_repos: [GetmoreApi.Repo]

# Configures the endpoint
config :getmore_api, GetmoreApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oeIhEXld2sqfM3YtpfEODQKbcz4K+lrlS4vJAvA6QbHOD0vD9lk5O32CNmKKI0+S",
  render_errors: [view: GetmoreApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: GetmoreApi.PubSub,
  live_view: [signing_salt: "kUlAJn6t"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
