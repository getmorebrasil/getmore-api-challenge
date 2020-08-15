exports.up = (knex) => {
  return knex.schema.createTable("products", function (table) {
    table.integer("productId").primary();
    table.string("productCategory").notNullable();
    table.string("productName").notNullable();
    table.string("productImage").notNullable();
    table.boolean("productStock").notNullable();
    table.float("productPrice").notNullable();
  });
};

exports.down = (knex) => {
  return knex.schema.dropTable("products");
};
