const ProductService = require("../services/ProductService");

module.exports = async () => {
  console.log("[x] Entering Consumer Get Product");
  return await ProductService.default.get();
};
