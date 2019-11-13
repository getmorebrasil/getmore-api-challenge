const { Handler, connectionProducer } = require('../rpc-client-js/producer');

async function mainProducer() {
    const host = 'amqp://localhost:5672';
    const queueName = 'test_queue';
    const connection = await connectionProducer(host, queueName);
    const handlers = await Handler.getHandlers();
    console.log(handlers);

    Handler.getProducts = async num => { };

    const target = 'getProducts';
    const getFoo = await Handler[target]();
    console.log(getFoo);

    connection.close();
}

module.exports = {
    mainProducer
};