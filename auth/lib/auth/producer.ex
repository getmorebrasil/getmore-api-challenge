defmodule Auth.Producer do
  def invite_message message do
    exchange = "auth_response_exchange"
    queue = "auth_response_queue"

    {:ok, conn} = AMQP.Connection.open
    {:ok, chan} = AMQP.Channel.open(conn)
    AMQP.Queue.bind(chan, queue, exchange)
    AMQP.Basic.publish chan, exchange, "", message
    AMQP.Connection.close(conn)
  end

end
