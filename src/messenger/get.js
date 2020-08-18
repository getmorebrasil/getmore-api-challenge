const ProductService = require("../services/ProductService");
const ProductDTO = require("../interfaces/ProductDTO");

module.exports = async () => {
  return await ProductService.get();
};
