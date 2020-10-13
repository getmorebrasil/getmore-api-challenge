defmodule Market.Repo do
  use Ecto.Repo,
    otp_app: :market,
    adapter: Ecto.Adapters.Postgres
end
