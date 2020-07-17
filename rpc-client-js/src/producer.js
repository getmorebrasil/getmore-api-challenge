const amqp = require('amqplib');
const uuid = require('node-uuid');

const Handler = {
    get: function (target, name) {
        if (!target[name] && name !== 'getHandlers') {
            console.error(`Warning: ${name}() is not defined on interface`);
            console.error(`To define ${name}() add in Handler.${name} = async (<parameters>) => {};`);
        }
        return consumerCurry(name);
    }
};

const proxyHandler = new Proxy({}, Handler);

module.exports.Handler = proxyHandler;

const consumerCurry = target => async (params, options) => {
    return await consumer({ target, params }, options);
};

let connection;
let assertQueue;

const conn = async (urlConnection, assertQueueName) => {
    connection = await amqp.connect(urlConnection);
    assertQueue = assertQueueName;
    return connection;
};

module.exports.connectionProducer = conn;

const consumer = async (n, options = {}) => {
    const channel = await connection.createChannel();
    const correlationId = uuid();
    const rpcResponse = await new Promise(async (resolve) => {
        const maybeAnswer = (msg) => {
            if (msg.properties.correlationId === correlationId) {
                switch (options.return) {
                    case 'String':
                        resolve(msg.content.toString());
                        break;
                    case 'Buffer':
                        resolve(msg.content);
                        break;
                    default:
                        resolve(JSON.parse(msg.content.toString()));
                        break;
                }
            }
        };
        const { queue } = await channel.assertQueue('', { exclusive: true });
        channel.consume(queue, maybeAnswer, { noAck: true });

        console.log(`[x] Requesting ${n.target}(${n.params}) to queue ${assertQueue}`);
        channel.sendToQueue(assertQueue, Buffer.from(JSON.stringify(n)), {
            correlationId: correlationId, replyTo: queue
        });
    });

    return rpcResponse;
}
