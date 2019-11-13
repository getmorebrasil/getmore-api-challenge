const interfaceRpc = require('./interface');
const startConsumer = require('../rpc-client-js/consumer');
const db = require('../database')

const host = 'amqp://guest:guest@localhost:5672';
const queueName = 'test_queue'
console.log(interfaceRpc())
db.client.connect();
startConsumer(host, queueName, interfaceRpc).then((e) => {
    console.log(e);
});
// db.client.end();

module.exports.Server;