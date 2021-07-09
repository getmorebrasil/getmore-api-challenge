defmodule Api.Error do
  @moduledoc """
  Error struct to transport between layers
  """
  @keys [:status, :content]
  @enforce_keys @keys

  defstruct @keys

  @typedoc """
  Error definition
  """
  @type t :: %__MODULE__{status: atom(), content: any()}

  @spec build(atom(), any) :: t()
  @doc """
  Create new Error struct
  """
  def build(status, content) when is_atom(status) do
    %__MODULE__{status: status, content: content}
  end

  @spec build_message_error(binary()) :: t()
  @doc """
  Create new Error struct from message
  """
  def build_message_error(message) when is_binary(message) do
    build(:bad_request, message)
  end
end
