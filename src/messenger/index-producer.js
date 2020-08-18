const { Handler, connectionProducer } = require('../dependencies/rpc-client-js/producer');

const mainProducer = async (data) => {
  const host = 'amqp://guest:guest@getmore_rabbit:5672';
  const queueName = 'queue1';

  const connection = await connectionProducer(host, queueName);
  const handlers = await Handler.getHandlers();
  Handler.create = async () => {};

  const target = 'create';
  const resp = await Promise.all([
    Handler[target](data)
  ]);
  console.log(resp);

  /* INVESTIGAR POR QUE A CONEXÃO NÃO ESTÁ FECHANDO */
  await connection.close();
};

module.exports = mainProducer;
