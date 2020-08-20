const startConsumer = require('../dependencies/rpc-client-js/consumer');
const InterfaceRPC = require('./interfaceRPC');

const host = 'amqp://guest:guest@rabbit:5672';
const queueName = 'queue1';

startConsumer(host, queueName, InterfaceRPC).then((e) => {
    console.log(e);
});

module.exports.Consumer;
