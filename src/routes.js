const express = require("express");
const connection = require("./database/connection");

const routes = express.Router();

routes.get("/products", async (req, res) => {
  var { n = 10, p = 1 } = req.query;
  if (n < 1) {
    n = 10;
  }
  if (p < 1) {
    p = 1;
  }

  const prods = await connection("products")
    .limit(n)
    .offset((p - 1) * n)
    .select("*");

  return res.json(prods);
});

module.exports = routes;
