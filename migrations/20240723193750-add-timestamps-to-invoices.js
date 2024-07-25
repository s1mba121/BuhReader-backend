"use strict";

module.exports = {
    up: async (queryInterface, Sequelize) => {
        await queryInterface.addColumn("Invoices", "createdAt", {
            type: Sequelize.DATE,
            defaultValue: Sequelize.literal("CURRENT_TIMESTAMP"),
            allowNull: false,
        });
        await queryInterface.addColumn("Invoices", "updatedAt", {
            type: Sequelize.DATE,
            defaultValue: Sequelize.literal(
                "CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"
            ),
            allowNull: false,
        });
    },

    down: async (queryInterface, Sequelize) => {
        await queryInterface.removeColumn("Invoices", "createdAt");
        await queryInterface.removeColumn("Invoices", "updatedAt");
    },
};
