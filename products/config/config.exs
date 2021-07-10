import Config

config :products, ecto_repos: [Products.Repo]

config :products, Products.Consumer, rabbitmq_uri: System.get_env("RABBITMQ_URI")

import_config "#{Mix.env()}.exs"
