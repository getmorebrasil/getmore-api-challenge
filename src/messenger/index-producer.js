const { Handler, connectionProducer } = require('../dependencies/rpc-client-js/producer');

module.exports = {

  productCreationProducer: async function (data) {
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
    setTimeout(() => (connection.close()), 500)

    return true;
  },

  productListProducer: async function () {
    const host = 'amqp://guest:guest@getmore_rabbit:5672';
    const queueName = 'queue1';

    const connection = await connectionProducer(host, queueName);
    console.log('Conecting into Rabbit server at %s', host);
    console.log('Using queue %s', queueName)
    const handlers = await Handler.getHandlers();
    Handler.get = async () => {};

    const target = 'get';
    const resp = await Promise.all([
      Handler[target]()
    ]);
    console.log(resp);

    /* INVESTIGAR POR QUE A CONEXÃO NÃO ESTÁ FECHANDO */
    setTimeout(() => (connection.close()), 500)

    return resp;
  }

}
