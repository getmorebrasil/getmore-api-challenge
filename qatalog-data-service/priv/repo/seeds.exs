# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Qatalog.Repo.insert!(%Qatalog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias QatalogData.{Product, Repo}

with data <- File.read!("products.json"),
			products <- Jason.decode!(data, %{}) do
		products
		|> Enum.each(
				fn product ->
						product |> Product.changeset |> Repo.insert
				end
		)
end
