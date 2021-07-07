defmodule ApiApp.Repo do
  use Ecto.Repo,
    otp_app: :apiApp,
    adapter: Ecto.Adapters.Postgres
end
