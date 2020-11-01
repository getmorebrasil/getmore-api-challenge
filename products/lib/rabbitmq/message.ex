defmodule Rabbitmq.Message do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: Messages)
  end

  def init message do
    {:ok, message}
  end

  def handle_call(:get, _from, value) do
    {:reply, value, value}
  end

  def handle_cast({:set, message}, last_message) do
    IO.puts "Discart last message: #{inspect last_message}"
    { :noreply, message }
  end

  def read do
    response = get()
    set []
    response
  end

  def get do
    GenServer.call(Messages, :get)
  end

  def set message do
    GenServer.cast(Messages, {:set, message})
  end
end
