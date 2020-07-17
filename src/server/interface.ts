import { seachProducts } from '../repositories/seach-products-database'

interface Product {
    productId: number,
    productCategory: string,
    productName: string,
    productImage: string,
    productStock: boolean,
    productPrice: string
}

export default () => ({
    async getProducts({page = 0, productsPerPage = 5}): Promise<Product[]> {
        const res = await seachProducts(page, productsPerPage)
        return res
    }
})
