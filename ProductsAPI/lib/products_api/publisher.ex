defmodule ProductsAPI.Publisher do
  @amqp_uri "amqp://ihriviqq:coSZi6PeQ1dckcWi18LPW6urc9hHl8dN@orangutan.rmq.cloudamqp.com/ihriviqq"

  def publish(exchange, page, page_size) do
    {:ok, chan, queue} = start_init()

    {:ok, payload} = Jason.encode(%{page: page, page_size: page_size})
    sender_id = random_string(10)

    AMQP.Basic.consume(chan, queue, nil, no_ack: true)

    AMQP.Basic.publish(chan,
      exchange,
      "",
      payload,
      reply_to: queue,
      correlation_id: sender_id,
      content_type: "application/json"
      )

    receive do
      {:basic_deliver, payload, %{correlation_id: ^sender_id}} -> payload
    end
  end

  defp start_init do
    {:ok, conn} = AMQP.Connection.open(@amqp_uri)
    {:ok, chan} = AMQP.Channel.open(conn)
    {:ok, %{queue: queue}} = AMQP.Queue.declare(chan, "", exclusive: true)

    {:ok, chan, queue}
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
