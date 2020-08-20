require('../messenger/index-consumer.js');
const { productListProducer } = require('../messenger/index-producer.js');
import { Request, Response } from "express";
import ProductDTO from "../interfaces/ProductDTO";
import Paginator from "../utils/Paginator";
type ProductCollectionDTO = ProductDTO[];

export default {

  async get(req: Request, res: Response) {
    const products: ProductCollectionDTO = await productListProducer();

    var { page, size } = req.query;

    page = Number.parseFloat(page);
    size = Number.parseFloat(size);

    const filteredPage = Number.isNaN(page) ? 1 : page;
    const filteredSize = Number.isNaN(size) ? 10 : size;

    const paginatedProducts = new Paginator(products, filteredPage, filteredSize).apply();

    if('errors' in paginatedProducts) {
      res.status(400);
    }

    res.json(paginatedProducts);
  }

}
