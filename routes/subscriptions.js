// routes/subscriptions.js
const express = require("express");
const subscriptionController = require("../controllers/subscriptionController");
const authMiddleware = require("../middleware/authMiddleware");
const router = express.Router();

router.post("/subscribe", authMiddleware, subscriptionController.subscribe);
router.get(
    "/check-subscription/:userId",
    authMiddleware,
    subscriptionController.checkSubscription
);

module.exports = router;
