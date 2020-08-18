import * as data from '../../products.json';
import { Product } from '../models/Product.entity';
import { getRepository } from 'typeorm';

export default {
  get(){},

  async createDependences() {
    const repository = getRepository(Product);

    const result = await repository.findAndCount();

    /* REFACTOR THIS TO USE MESSAGER */
    if(result[1] == 0) {
      for (var i in data){
        repository.save<Product>(data[i]);
      }
    }
  }
}
