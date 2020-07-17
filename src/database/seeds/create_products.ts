import Knex from 'knex'
// import products from '../../../products.json'

export async function seed(knex: Knex) {
    // console.log(products)
    await knex('products').insert([
        {
            productId: 1001,
            productCategory: "Category 2",
            productName: "Product 1",
            productImage: "https://picsum.photos/400?image=333",
            productStock: true,
            productPrice: "1871.425"
        },
        {
            productId: 1002,
            productCategory: "Category 2",
            productName: "Product 2",
            productImage: "https://picsum.photos/400?image=516",
            productStock: false,
            productPrice: "3874.773"
        },
        {
            productId: 1003,
            productCategory: "Category 3",
            productName: "Product 3",
            productImage: "https://picsum.photos/400?image=949",
            productStock: false,
            productPrice: "1145.060"
        },
        {
            productId: 1004,
            productCategory: "Category 4",
            productName: "Product 4",
            productImage: "https://picsum.photos/400?image=93",
            productStock: true,
            productPrice: "1622.080"
        },
        {
            productId: 1005,
            productCategory: "Category 2",
            productName: "Product 5",
            productImage: "https://picsum.photos/400?image=912",
            productStock: false,
            productPrice: "1620.229"
        }
    ])
}