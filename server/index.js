const producer = require('./index-producer');
const consumer = require('./index-consumer');
const express = require('express');
const app = express();

app.get('/products/:itemsPerPage&:page', async function (req, res, next) {
  const { itemsPerPage, page } = req.params;
  console.log(`\x1b[35mrequest: '/products', itemsPerPage: ${itemsPerPage}, page: ${page}\x1b[0m`);
  let response = await producer.mainProducer(itemsPerPage, page);
  res.send(response);
});

app.listen(4000, () => {
  console.log('Server is running.. on Port 4000');
});