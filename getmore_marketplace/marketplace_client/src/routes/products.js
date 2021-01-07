const router = require("express").Router();
const productsController = require("../controller/products");

router.get("/", (req, res) => productsController.getAll(req, res));

module.exports = router;
