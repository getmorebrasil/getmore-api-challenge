const producer = require('./index-producer');
const consumer = require('./index-consumer');
const express = require('express');
const app = express();
const cors = require('cors');

app.get('/', async function (req, res, next) {
  res.send('online');
});

app.get(['/products/:itemsPerPage&:page', '/products'], async function (req, res, next) {
  const { itemsPerPage, page } = req.params;
  console.log(`\x1b[35mrequest: '/products', itemsPerPage: ${itemsPerPage}, 
    page: ${page}\x1b[0m`);
  let response = await producer.mainProducer(itemsPerPage, page);
  res.send(response);
});

app.use(cors());
app.listen(4000, () => {
  console.log('Server is running.. on Port 4000');
});