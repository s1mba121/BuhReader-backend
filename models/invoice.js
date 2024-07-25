// models/invoice.js
const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Invoice = sequelize.define(
    "Invoice",
    {
        user_id: {
            type: DataTypes.INTEGER,
            references: {
                model: "users",
                key: "id",
            },
        },
    },
    {
        timestamps: false,
    }
);

module.exports = Invoice;
