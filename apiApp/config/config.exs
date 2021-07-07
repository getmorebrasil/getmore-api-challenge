# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :apiApp,
  ecto_repos: [ApiApp.Repo]

# Configures the endpoint
config :apiApp, ApiAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "fOEDGRkSw5w0x4fzPT6W7zY0XxbsCaphKkI8DHY5tELSZZa1yq69FXQRAe81jdUN",
  render_errors: [view: ApiAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ApiApp.PubSub,
  live_view: [signing_salt: "ZUl4qR9j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
