require('dotenv').config();
const { Client } = require('pg');
const products = require('../products');
const client = new Client();
const { 
  queryCreateTableProducts,
  queryDeleteProducts,
  queryInsertProducts,
  queryGetProducts
} = require('./queries');

// create the products table
const createTableProducts = async () => {
  let res = await client.query(queryCreateTableProducts);
  return res;
};

// insert the products from 'products.js' to the database
const insertProducts = async () => {
  await client.query(queryDeleteProducts);
  await client.query(queryInsertProducts(products))
    .catch(err => {console.log(err); return err})

    return 'success';
};

// returns the products according to quantity per page and the page
const getProducts = async (itemsPerPage = 5, page = 0) => {
  let products = await client.query(queryGetProducts(itemsPerPage, page))
    .catch(err => console.log(err));
  return products.rows;
}

// returns all database products
const getAllProducts = async () => {
  let products = await client.query(queryGetAllProducts())
    .catch(err => console.log(err));

  return products.rows;
}

module.exports = {
  client,
  createTableProducts,
  insertProducts,
  getProducts,
  getAllProducts
}