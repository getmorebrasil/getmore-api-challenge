const router = require("express").Router();
const productsRoutes = require("./products");

router.use("/products", productsRoutes);

module.exports = router;
