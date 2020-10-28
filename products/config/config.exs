import Config

config :products, Products.Repo,
  database: "products_repo",
  username: "postgres",
  password: "Breeckway1@",
  hostname: "localhost"

config :products, ecto_repos: [Products.Repo]
