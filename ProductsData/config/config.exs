import Config

config :products_data, ProductsData.Repo,
  username: "postgres",
  password: "123456",
  database: "products_api_dev",
  hostname: "localhost"

config :products_data, ecto_repos: [ProductsData.Repo]
