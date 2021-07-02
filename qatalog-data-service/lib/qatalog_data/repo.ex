defmodule QatalogData.Repo do
  use Ecto.Repo,
    otp_app: :qatalog_data,
    adapter: Ecto.Adapters.Postgres
end
