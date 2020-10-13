use Mix.Config

# Configure your database
config :market, Market.Repo,
  username: "postgres",
  password: "postgres",
  database: "market_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: {Utils.ConsoleLogger, :format}, metadata: :all

