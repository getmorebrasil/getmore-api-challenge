require('../messenger/index-consumer');
const producer = require('../messenger/index-producer');
import * as data from '../../products.json';
import ProductDTO from '../interfaces/ProductDTO';

/*
  Why don't I use seeding? Typeorm does not provide
  a viable wway to do it, so I decide to implemnt using
  this file
*/

function delay(ms: number) {
  return new Promise( resolve => setTimeout(resolve, ms) );
}

(async () => {

  for (var i in data){
    const dto: ProductDTO = {
      productId: data[i].productId,
      productCategory: data[i].productCategory,
      productName: data[i].productName,
      productImage: data[i].productImage,
      productStock: data[i].productStock,
      productPrice: data[i].productPrice
    };

    producer(dto);
  }
})();
