producer = require('./index-producer');

(async () => {
  let resp = await producer.mainProducer();
  console.log(resp);
})()