const express = require("express");
const producer = require("./index-producer");
require("./index-consumer");

const routes = express.Router();

routes.get("/products", async (req, res) => {
  let { n = 10, p = 0 } = req.query;

  const prodRes = await producer.mainProducer(n, p);
  return res.json(prodRes);
});

module.exports = routes;
