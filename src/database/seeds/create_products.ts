"use strict"
import Knex from 'knex'
import products from '../../../products.json'

export async function seed(knex: Knex) {
  console.log(products)
  await knex('products').insert([products])
}