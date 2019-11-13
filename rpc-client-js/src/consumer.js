const amqp = require('amqplib');

let ServerInterfaceProducerCache;
let ServerInterface = {
    async getHandlers() /*getHandles(): Array<Signature> */ {
        const handlers = ServerInterfaceProducerCache.valueOf().toString().match(/\/\*.+\*\//g).map(definition => definition.replace(/[\/\*\\*\/]/g, '').trim());
        const handlersJoined = handlers.join(';');
        const signatures = Object.entries(this).map(entrie => {
            if (handlersJoined.indexOf(entrie[0]) === -1) {
                return entrie[0] !== 'getHandlers' ?
                    { [entrie[0]]: entrie[1].toString().match(/\D+(.+)[| ]{/)[0].replace(/\{$/, '').trim() } :
                    { [entrie[0]]: entrie[1].toString().match(/\s+\/\*[\W\D]+\*\//g)[0].replace(/[\/\*\\*\/]/g, '').trim() };
            }
            const definition = handlers.find(handler => returner = handler.indexOf(entrie[0]) > -1);
            return { [entrie[0]]: definition }
        })
        return signatures;
    }
}

module.exports.startServer = async function (urlConnection, queueName, ServerInterfaceProducer) {
    ServerInterfaceProducerCache = ServerInterfaceProducer;
    ServerInterface = { ...ServerInterfaceProducer(), ...ServerInterface };
    const connection = await amqp.connect(urlConnection).catch(e => {
        throw new Error('Unable to connect the queue server');
    });
    process.once('SIGINT', function () { connection.close(); });
    const channel = await connection.createChannel();

    await channel.assertQueue(queueName, { durable: false });

    channel.prefetch(1);
    await channel.consume(queueName, reply);

    console.log(` [x] Awaiting RPC requests from queue ${queueName}`);

    async function reply(rpcRequest) {
        const { target, params } = JSON.parse(rpcRequest.content.toString());
        let returner = `${target}() is not defined on serverInterface \n`;
        if (typeof ServerInterface[target] === 'function') {
            returner = await ServerInterface[target](params || undefined).catch(err => err);
        }
        channel.sendToQueue(rpcRequest.properties.replyTo, Buffer.from(JSON.stringify(returner)), { correlationId: rpcRequest.properties.correlationId });
        channel.ack(rpcRequest);
    }

    return true;
}
