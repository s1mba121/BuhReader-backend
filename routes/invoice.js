// routes/invoice.js
const express = require("express");
const invoiceController = require("../controllers/invoiceController");
const authMiddleware = require("../middleware/authMiddleware");
const upload = require("../config/multerConfig");
const router = express.Router();

router.post(
    "/read-invoice",
    authMiddleware,
    upload.single("file"),
    invoiceController.readInvoice
);

module.exports = router;
