import 'reflect-metadata';
import '../database/connection';
import { Product } from '../models/Product.entity';
import { getRepository } from 'typeorm';
import ProductDTO from '../interfaces/ProductDTO';
type ProductCollectionDTO = ProductDTO[];

export default {
  async get(){
    const repository = getRepository(Product);
    const data: Product[]= await repository.find();
    const productList: ProductCollectionDTO = data.map(
      (product: Product) => {
        const dto: ProductDTO = {
          productId: product.productId,
          productCategory: product.productCategory,
          productName: product.productName,
          productImage: product.productImage,
          productStock: product.productStock,
          productPrice: product.productPrice
        };

        return dto;
      }
    );
    return
  },

  async create(data: ProductDTO) {
    console.log("[x] Entering Product Service")
    const repository = getRepository(Product);
    const product: Product = await repository.save<Product>(data);
    const productDTO: ProductDTO = {
      productId: product.productId,
          productCategory: product.productCategory,
          productName: product.productName,
          productImage: product.productImage,
          productStock: product.productStock,
          productPrice: product.productPrice
    };
    return productDTO;
  }
}
