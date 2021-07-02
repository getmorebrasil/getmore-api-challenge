# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :qatalog_data,
  ecto_repos: [QatalogData.Repo]

config :qatalog_data, QatalogData.Repo,
  migration_primary_key: [name: :uuid, type: :binary_id],
  migration_foreign_key: [name: :uuid, type: :binary_id]

  # Configures the endpoint
config :qatalog_data, QatalogDataWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9/dVdZjCzJ8LrAMpUiN8zHgjMvzbgby+qkcsM1bOqlm7ArvfutbUF6H72fGiVX5x",
  render_errors: [view: QatalogDataWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: QatalogData.PubSub,
  live_view: [signing_salt: "iPOMld1z"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
