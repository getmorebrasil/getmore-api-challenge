import { seachProducts } from '../repositories/seach-products-database'

export interface Product {
    productId: number,
    productCategory: string,
    productName: string,
    productImage: string,
    productStock: boolean,
    productPrice: string
}

export default () => ({
    async getProducts({page = 0, productsPerPage = 5}): Promise<Product[]> {
        console.log('olá mundo')
        const res = await seachProducts(page, productsPerPage)
        return res
    }
})
