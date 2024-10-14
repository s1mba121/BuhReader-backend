// routes/invoice.js
const express = require("express");
const invoiceController = require("../controllers/invoiceController");
const authMiddleware = require("../middleware/authMiddleware");
const upload = require("../config/multerConfig");
const router = express.Router();

router.post(
    "/read-invoice",
    authMiddleware,
    upload.array("files", 10), // Change to array and specify field name and limit
    invoiceController.readInvoice
);

module.exports = router;
