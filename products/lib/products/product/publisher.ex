defmodule Products.Product.Publisher do
  @moduledoc """
  Provides methods to publish messages usiing AMQP
  """

  alias AMQP

  @doc """
  Starts the connection and the channel, then publish a message with the given params
  """
  def publish_json(response, meta) do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    AMQP.Basic.publish(channel,
                       "",
                       meta.reply_to,
                       response,
                       correlation_id: meta.correlation_id,
                       content_type: "application/json")
  end
end
