import Knex from 'knex'
import products from '../../../products.json'

export async function seed(knex: Knex) {
    for (let prod of products) {
        await knex('products').insert(prod)
    }
}