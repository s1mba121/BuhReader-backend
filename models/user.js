// models/user.js

const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const User = sequelize.define(
    "User",
    {
        email: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
        },
        password: {
            type: DataTypes.STRING,
            allowNull: false,
        },
        is_verified: {
            type: DataTypes.BOOLEAN,
            defaultValue: false,
        },
        verification_code: {
            type: DataTypes.STRING(6),
        },
        reset_code: {
            type: DataTypes.STRING(6),
        },
    },
    {
        timestamps: true,
        underscored: true,
    }
);

module.exports = User;
