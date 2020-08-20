require('../messenger/index-consumer.js');
const { productListProducer } = require('../messenger/index-producer.js');
import { Request, Response } from "express";
import ProductDTO from "../interfaces/ProductDTO";
import Paginator from "../utils/Paginator";
type ProductCollectionDTO = ProductDTO[];

export default {

  async get(req: Request, res: Response) {
    const products: ProductCollectionDTO = await productListProducer();

    const { page, size } = req.query;

    const paginatedProducts = new Paginator(products, page, size).apply();

    res.json(paginatedProducts);
  }

}
