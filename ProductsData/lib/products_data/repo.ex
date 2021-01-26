defmodule ProductsData.Repo do
  use Ecto.Repo,
    otp_app: :products_data,
    adapter: Ecto.Adapters.Postgres
end
