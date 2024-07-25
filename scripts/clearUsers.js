const sequelize = require("../config/database");
const User = require("../models/user");

const clearUsers = async () => {
    try {
        await sequelize.authenticate();
        console.log("Database connection established.");

        await User.destroy({ where: {} });
        console.log("All users have been deleted.");
    } catch (error) {
        console.error("Error clearing users:", error);
    } finally {
        await sequelize.close();
    }
};

clearUsers();
