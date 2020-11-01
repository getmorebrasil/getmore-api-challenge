defmodule Auth do
  use Application

  def start(_type, _args) do
    Auth.Consumer.start_link
  end

end
