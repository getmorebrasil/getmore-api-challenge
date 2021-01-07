const amqp = require("amqplib/callback_api");
const { generateUuid } = require("../utils");

function getAll(req, res) {
  amqp.connect("amqp://rabbitmq:5672", (connectionError, connection) => {
    if (connectionError) throw connectionError;

    connection.createChannel((createChannelError, channel) => {
      if (createChannelError) throw createChannelError;

      channel.assertQueue(
        "",
        {
          exclusive: true,
        },
        (assertQueueError, q) => {
          if (assertQueueError) throw assertQueueError;

          const correlationId = generateUuid();
          const query = req.query;

          channel.consume(
            q.queue,
            (msg) => {
              if (msg.properties.correlationId == correlationId) {
                res.status(200).send(msg.content);
              }
            },
            {
              noAck: true,
            }
          );

          channel.sendToQueue("rpc_queue", Buffer.from(JSON.stringify(query)), {
            correlationId: correlationId,
            replyTo: q.queue,
          });
        }
      );
    });
  });
}

module.exports = { getAll };
