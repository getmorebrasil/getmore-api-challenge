defmodule GetmoreApiChallenge.Repo do
  use Ecto.Repo,
    otp_app: :getmoreApiChallenge,
    adapter: Ecto.Adapters.Postgres

  # Pagination
  use Scrivener, page_size: 5

end
