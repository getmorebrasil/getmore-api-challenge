defmodule GetmoreApi.Repo do
  use Ecto.Repo,
    otp_app: :getmore_api,
    adapter: Ecto.Adapters.Postgres
end
