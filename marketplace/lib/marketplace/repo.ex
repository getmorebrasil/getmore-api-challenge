defmodule Marketplace.Repo do
  use Ecto.Repo,
    otp_app: :marketplace,
    adapter: Ecto.Adapters.Postgres
end
