import { Request, Response } from "express";
import ProductService from "../services/ProductService";


export default {

  async get(req: Request, res: Response) {
    res.send('produto');
  }

}
