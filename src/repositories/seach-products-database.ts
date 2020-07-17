import knex from '../database/connection'

const seachProducts = async (page: number, productsPerPage: number) => {

    const res = knex('products').orderBy('productId').limit(productsPerPage).offset(page * productsPerPage)  
    return res
}

export { seachProducts }
