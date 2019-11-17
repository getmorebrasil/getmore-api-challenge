const producer = require('./index-producer');
require('./index-consumer');
require('dotenv').config();
const express = require('express');
const app = express();
const cors = require('cors');

app.get('/', async function (req, res, next) {
  res.send('online');
});

app.get(['/products/:page&:itemsPerPage', '/products/:page'], async function (req, res, next) {
  let { page, itemsPerPage } = req.params;
  let maxPerPage = parseInt(process.env.MAX_ITEMS_PER_PAGE) || 10;

  if (itemsPerPage > maxPerPage)
    return res.status(400).send({error: `Maximum of ${maxPerPage} items per page`});
  
  console.log(`\x1b[35m
    Request: '/products', page: ${page}, itemsPerPage: ${itemsPerPage} \x1b[0m`);
  let response = await producer.mainProducer(page, itemsPerPage);
  res.send(response);
});

app.use(cors());
app.listen(4000, () => {
  console.log('Server is running.. on Port 4000');
});