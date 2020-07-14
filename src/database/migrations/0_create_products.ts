import Knex from 'knex'

export async function up(knex: Knex){
  // CRIAR A TABELA
  return knex.schema.createTable('products', table => {
    table.integer('productId').primary()
    table.string('productCategory').notNullable()
    table.string('productName').notNullable()
    table.string('productImage').notNullable()
    table.boolean('productStock').notNullable()
    table.string('productPrice').notNullable()
  });
}

export async function down(knex: Knex){
  // DELETAR A TABELA
  return knex.schema.dropTable('products')
}