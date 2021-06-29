defmodule UsersApi.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :description, :string
    field :task, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:task, :description])
    |> validate_required([:task, :description])
  end
end
