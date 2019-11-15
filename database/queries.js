// returns the create table query
const queryCreateTableProducts = `
  CREATE TABLE IF NOT EXISTS Products(
    productId int primary key,
    productCategory varchar,
    productName varchar,
    productImage varchar,
    productStock boolean,
    productPrice float
  );
`;

// returns the delete table query
const queryDeleteProducts = 'DELETE from Products';

/**
 * returns the insert products query, according to the
 * 'products' from parameters
 */
const queryInsertProducts = (products) => {
  productsFormat = products.map(product => (
    `(
      ${product.productId},
      '${product.productCategory}',
      '${product.productName}',
      '${product.productImage}',
      ${product.productStock},
      ${product.productPrice}
    )`
  ));
  return `INSERT INTO Products values ${productsFormat}`;
};

/**
 * returns the get products query, according to the
 * itemsPerPage and page from parameters
 */
const queryGetProducts = (itemsPerPage = 5, page = 0) => {
  let query = `
    SELECT * FROM products ORDER BY productid ASC
    LIMIT ${itemsPerPage} OFFSET ${page * itemsPerPage}
  `;
  // console.log(query)
  return query;
}

// returns all the producs in database
const queryGetAllProducts = () => {
  return 'SELECT * FROM products';
}

module.exports = {
  queryCreateTableProducts,
  queryDeleteProducts,
  queryInsertProducts,
  queryGetProducts,
  queryGetAllProducts
}