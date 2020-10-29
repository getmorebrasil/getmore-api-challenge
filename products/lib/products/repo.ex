defmodule Products.Repo do
  use Ecto.Repo,
    otp_app: :products,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
