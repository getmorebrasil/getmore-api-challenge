const products = require("../../../products.json");

exports.seed = (knex) => {
  // Deletes ALL existing entries
  return knex("products")
    .del()
    .then(async () => {
      // Inserts seed entries
      for (let p of products) {
        // Need to await
        await knex("products").insert(p);
      }
    });
};
