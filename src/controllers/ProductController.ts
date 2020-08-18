import { Request, Response } from "express";
import { create } from "domain";
import ProductService from "../services/ProductService";


export default {

  async get(req: Request, res: Response) {
    ProductService.createDependences()
  }

}
