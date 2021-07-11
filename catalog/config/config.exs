import Config

db_url = System.get_env("DB_URL", "postgres://postgres:postgres@localhost:5432/catalog_dev")

config :catalog, Catalog.Repo, url: db_url

config :catalog, ecto_repos: [Catalog.Repo]
