const { Handler, connectionProducer } = require("../rpc-client-js/producer");

async function mainProducer(n, p) {
  const host = "amqp://localhost:5672";
  const queueName = "test_queue";
  const connection = await connectionProducer(host, queueName);
  const handlers = await Handler.getHandlers();
  // console.log(handlers);

  Handler.getProducts = async () => {};

  const target = "getProducts";
  const getProducts = await Handler[target]({ n, p });
  // console.log(getProducts);
  connection.close();

  return getProducts;
}

// Export the function
module.exports = { mainProducer };
