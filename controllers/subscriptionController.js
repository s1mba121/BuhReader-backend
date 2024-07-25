// controllers/subscriptionController.js
const Subscription = require("../models/subscription");
const User = require("../models/user");

exports.subscribe = async (req, res) => {
    const { plan } = req.body;
    const userId = req.user.userId;

    try {
        const user = await User.findByPk(userId);

        if (!user) {
            return res.status(400).json({ error: "User not found" });
        }

        const existingSubscription = await Subscription.findOne({
            where: { user_id: userId },
        });

        if (existingSubscription) {
            if (existingSubscription.plan === "Lite" && plan === "Pro") {
                existingSubscription.plan = "Pro";
                existingSubscription.expiry_date.setMonth(
                    existingSubscription.expiry_date.getMonth() + 1
                );
                await existingSubscription.save();
                return res.status(200).json(existingSubscription);
            } else {
                return res
                    .status(400)
                    .json({ error: "User already has an active subscription" });
            }
        }

        let expiry_date = new Date();
        expiry_date.setMonth(expiry_date.getMonth() + 1);

        const subscription = await Subscription.create({
            user_id: userId,
            plan,
            expiry_date,
        });

        res.status(201).json(subscription);
    } catch (error) {
        console.error("Failed to create subscription:", error);
        res.status(500).json({ error: "Failed to create subscription" });
    }
};

exports.checkSubscription = async (req, res) => {
    const { userId } = req.params;

    try {
        const subscription = await Subscription.findOne({
            where: { user_id: userId },
        });

        if (!subscription) {
            return res.status(400).json({ error: "No subscription found" });
        }

        res.status(200).json(subscription);
    } catch (error) {
        console.error("Failed to retrieve subscription:", error);
        res.status(500).json({ error: "Failed to retrieve subscription" });
    }
};
