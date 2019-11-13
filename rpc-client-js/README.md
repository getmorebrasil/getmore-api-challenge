# rpc-client

This is a client rpc to work with a protocol amqp and a message brokers RabbitMQ

You only need to do is:

## To initiate a consumer or your server

> Create a interfaceRpc like this:
```javascript
module.exports = () => ({
    /* foo({ notMarried, name, age }): Promise<number> */
    foo({ notMarried, name, age }) {
        return Promise.resolve({ response: { name, notMarried, age } });
    },
    /* bar(number): Promise<number> */
    bar({ string }) {
        return Promise.resolve({ response: string.toUpperCase() });
    },
    boo({ number }) {
        return Promise.resolve({ response: number * 2 });
    },
    too
})
```
- Comments above the functions are returned to gethandlers() function. Functions that not have comments goin returned your implementation inside the interfaceRpc

> And call the function startConsumer(host, queueName, interfaceRpc), passing the host of message broker, the queue name and the interfaceRpc
```javascript
const host = 'amqp://guest:guest@localhost:5672'
const queueName = 'test_queue'

startConsumer(host, queueName, interfaceRpc).then((e) => {
    console.log(e);
});
```

## To initiate a producer or your client

> You only need call the function connectionProducer(host, queueName). The function getHandlers() is default and return all functions availables on Server or Consumer
```javascript
const host = 'amqp://localhost:5672';
const queueName = 'test_queue';

const connection = await connectionProducer(host, queueName);

const handlers = await Handler.getHandlers();
console.log(handlers);
```

> To call any function available, make like this
```javascript
Handler.foo = async num => { };
Handler.bar = async str => { };

const target = 'foo';
const getFoo = await Handler[target]({ notMarried: true, age: 22, name: 'balde' }, { return: 'String' });
console.log(getFoo);
```

> To close connection
```javascript
connection.close();
```

>View the /examples to understand a little more the functionality https://github.com/getmorebrasil/rpc-client-js
