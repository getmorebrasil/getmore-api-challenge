import { Router } from 'express';
import ProductController from '../controllers/ProductController';


const productRouter = Router();

productRouter.get('/', ProductController.get);

export default productRouter;
