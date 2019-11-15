const db = require('../database/index');

(async() => {
  await db.client.connect();
  let a = await db.createTableProducts();
  // console.log(a);
  await db.insertProducts();
  let res = await db.getProducts(2, 1);
  console.log(res);
  await db.client.end();
})()