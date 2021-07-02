# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :qatalog_api, QatalogApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5+KHQPxHY9cot/hrxjtxM8FQtQMz3geIRNfPQbOowMs44poMTp6kQP+6yrt2Nvl/",
  render_errors: [view: QatalogApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: QatalogApi.PubSub,
  live_view: [signing_salt: "HK1TP0Xn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
