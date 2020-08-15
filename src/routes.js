const express = require("express");
const connection = require("./database/connection");

const routes = express.Router();

routes.get("/products", async (req, res) => {
  const prods = await connection("products").select("*");

  return res.json(prods);
});

module.exports = routes;
