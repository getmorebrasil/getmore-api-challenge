defmodule Catalog.Repo do
  use Ecto.Repo,
    otp_app: :catalog,
    adapter: Ecto.Adapters.Postgres
end
