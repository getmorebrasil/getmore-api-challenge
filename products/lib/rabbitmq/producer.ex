defmodule Rabbitmq.Producer do

  @request_queue  "auth_request_queue"
  @exchange       "auth_request_exchange"

  defp open_connection exchange, queue do
    {:ok, conn} = AMQP.Connection.open()

    {:ok, chan} = AMQP.Channel.open(conn)

    # AMQP.Exchange.declare(chan, exchange)

    # AMQP.Queue.declare(chan, queue)

    AMQP.Queue.bind(chan, queue, exchange)

    {conn, chan}
  end

  defp close_connection conn do
    AMQP.Connection.close(conn)
  end

  def invite_message token do
    pid = self()
    {:ok, response} = JSON.encode({pid, token})

    {conn, chan} = open_connection(@exchange, @request_queue)
    AMQP.Basic.publish(chan, @exchange, "", response)
    close_connection conn
  end
end
