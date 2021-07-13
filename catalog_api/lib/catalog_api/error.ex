defmodule CatalogApi.Error do

  @derive {Jason.Encoder, only: [:code, :detail]}
  defstruct code: nil, detail: nil

  @type t :: %__MODULE__{code: integer(), detail: String.t()}
end
