defmodule GetmoreApi.Publisher do
  def publish(exchange, page, page_size) do
    {:ok, channel, queue} = start_init()

    {:ok, payload} = Jason.encode(%{page: page, page_size: page_size})
    sender_id = random_string(10)

    AMQP.Basic.consume(channel, queue, nil, no_ack: true)

    AMQP.Basic.publish(
      channel,
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
    {:ok, connection} = AMQP.Connection.open()
    {:ok, channel} = AMQP.Channel.open(connection)
    {:ok, %{queue: queue}} = AMQP.Queue.declare(channel, "", exclusive: true)

    {:ok, channel, queue}
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)
  end
end
