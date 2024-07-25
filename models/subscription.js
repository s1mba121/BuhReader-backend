// models/subscription.js
const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Subscription = sequelize.define(
    "Subscription",
    {
        user_id: {
            type: DataTypes.INTEGER,
            references: {
                model: "users",
                key: "id",
            },
        },
        plan: {
            type: DataTypes.ENUM("Lite", "Pro"),
            defaultValue: "Lite",
        },
        expiry_date: {
            type: DataTypes.DATE,
        },
    },
    {
        timestamps: true,
        underscored: true,
    }
);

module.exports = Subscription;
