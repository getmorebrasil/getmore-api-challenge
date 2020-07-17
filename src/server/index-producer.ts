import { Handler, connectionProducer } from '../../rpc-client-js/producer'

async function mainProducer (page: number, productsPerPage: number) {
    const host = 'amqp://localhost:5672'
    const queueName = 'test_queue'
    
    const connection = await connectionProducer(host, queueName)
    
    const handlers = await Handler.getHandlers()
    console.log(handlers)

    Handler.getProducts = async () => { }
    
    const target = 'getProducts';
    const getProducts = await Handler[target]({ page, productsPerPage })
    console.log(getProducts)

    connection.close()
    return getProducts
}

export default mainProducer