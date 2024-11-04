const express = require("express");
const router = express.Router();
const produtoController = require("../controllers/product_controller"); //adicionar
const path = require("path");

router.post("/postProduct", produtoController.postProduct);
router.get("/getAllProducts", produtoController.getProducts);
router.put("/putProduct/:id", produtoController.putProduct);
router.delete("/deleteProduct/:id", produtoController.deleteProduct);
router.get("/expiredAndNearExpiryProducts", produtoController.getExpiredAndNearExpiryProducts);

module.exports = router;
