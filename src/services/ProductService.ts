import 'reflect-metadata';
import '../database/connection';
import { Product } from '../models/Product.entity';
import { getRepository } from 'typeorm';
import ProductDTO from '../interfaces/ProductDTO';
type ProductCollectionDTO = ProductDTO[];

export default {
  async get(){
    console.log("[x] Entering Product Service to Get Data")
    const repository = getRepository(Product);
    const data: Product[]= await repository.find({
      order: { productId: "ASC" }
    });
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
    return productList;
  },

  async create(data: ProductDTO) {
    console.log("[x] Entering Product Service to Create Data")
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
