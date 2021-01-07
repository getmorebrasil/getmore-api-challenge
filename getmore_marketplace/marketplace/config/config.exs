import Config

config :marketplace, ecto_repos: [Marketplace.Repo]

config :marketplace, Marketplace.Repo,
  database: "marketplace_repo",
  username: "postgres",
  password: "postgres",
  hostname: "db",
  port: 5432
