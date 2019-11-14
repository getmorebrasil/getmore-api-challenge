const { Handler, connectionProducer } = require('../rpc-client-js/producer');

async function mainProducer(itemsPerPage, page) {
    const host = 'amqp://localhost:5672';
    const queueName = 'test_queue';
    const connection = await connectionProducer(host, queueName);
    const handlers = await Handler.getHandlers();
    // console.log(handlers);

    Handler.getProducts = async num => { };
    const target = 'getProducts';
    const getProducts = await Handler[target]({itemsPerPage: itemsPerPage, page: page});
    // console.log(getProducts);

    connection.close();
    return getProducts;
}

module.exports = {
    mainProducer
};