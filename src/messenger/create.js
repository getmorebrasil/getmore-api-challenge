const ProductService = require("../services/ProductService");
const ProductDTO = require("../interfaces/ProductDTO");

module.exports = async (data) => {
  console.log("[x] Entering Consumer Create Product");
  return await ProductService.default.create(data);
};
