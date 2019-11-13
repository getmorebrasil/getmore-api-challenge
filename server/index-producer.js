const { Handler, connectionProducer } = require('../rpc-client-js/producer');

(async function mainProducer() {
    const host = 'amqp://localhost:5672';
    const queueName = 'test_queue';
    const connection = await connectionProducer(host, queueName);
    const handlers = await Handler.getHandlers();
    console.log(handlers);

    Handler.foo = async num => { };
    Handler.bar = async str => { };

    const target = 'foo';
    const getFoo = await Handler[target]({ notMarried: true, age: 22, name: 'balde' }, { return: 'String' });
    console.log(getFoo);

    connection.close();
})()

module.exports.Producer;