defmodule Marketplace.Repo do
  use Ecto.Repo,
    otp_app: :marketplace,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
