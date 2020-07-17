import express, { Request, Response } from 'express'
import mainProducer from './server/index-producer'

const routes = express.Router()

routes.get('/products', async function(request: Request, response: Response) {
  const { page, productsPerPage } = request.body

  const products = await mainProducer(page, productsPerPage)
  response.json(products)
})

export default routes