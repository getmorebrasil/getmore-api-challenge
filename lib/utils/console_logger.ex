defmodule Utils.ConsoleLogger do
  @moduledoc """
  A custom console logger
  """
  def format(level, message, _timestamp, metadata) do
    case level do
      :debug ->
        "[#{metadata[:file]} #{metadata[:line]}]\n#{message}\n\n"

      :info ->
        "[INFO] #{message}\n"

      :warn ->
        "[#{metadata[:file]} #{metadata[:function]} #{metadata[:line]}]\n#{message}\n\n"

      :error ->
        "[#{metadata[:file]} #{metadata[:function]} #{metadata[:line]}]\n#{message}\n\n"
    end
  rescue
    _ -> "could not format: #{inspect({level, message, metadata})}\n"
  end
end

