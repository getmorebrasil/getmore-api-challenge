const db = require('../database/index');

(async() => {
  await db.client.connect();
  await db.createTableProducts();
  await db.insertProducts();
  let res = await db.getProducts(2, 1);
  console.log(res);
  await db.client.end();
})()