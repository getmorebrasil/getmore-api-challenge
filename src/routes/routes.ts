import { Router, Request, Response } from 'express';
import productRouter from './product.routes';


const routes = Router();

routes.get('/ping', (req: Request, res: Response) => (res.send('pong')))
routes.use('/products', productRouter);

export default routes;
