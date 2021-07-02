import Config

config :products, ecto_repos: [Products.Repo]

import_config "#{Mix.env()}.exs"
