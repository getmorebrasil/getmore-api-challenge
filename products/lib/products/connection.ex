defmodule Products.Connection do
  use GenServer
  require Logger
  alias AMQP.Connection

  @host "amqp://localhost"
  @reconnect_interval 10_000

  def start_link(opts \\ [name: __MODULE__]) do
    GenServer.start_link(__MODULE__, nil, opts)
  end

  def init(_) do
    send(self(), :connect)
    {:ok, nil}
  end

  def get_connection do
    case GenServer.call(__MODULE__, :get) do
      nil -> {:error, :not_connected}
      conn -> {:ok, conn}
    end
  end

  def handle_call(:get, _, conn) do
    {:reply, conn, conn}
  end

  def handle_info(:connect, conn) do
    case Connection.open(@host) do
      {:ok, conn} ->
        # Get notifications when the connection goes down
        Process.monitor(conn.pid)
        {:noreply, conn}

      {:error, _} ->
        Logger.error("Failed to connect #{@host}. Reconnecting later...")
        # Retry later
        Process.send_after(self(), :connect, @reconnect_interval)
        {:noreply, nil}
    end
  end

  def handle_info({:DOWN, _, :process, _pid, reason}, _) do
    # Stop GenServer. Will be restarted by Supervisor.
    {:stop, {:connection_lost, reason}, nil}
  end
end
