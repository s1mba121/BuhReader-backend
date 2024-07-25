// server.js
const express = require("express");
const cors = require("cors");
const sequelize = require("./config/database");
const bodyParser = require("body-parser");
const User = require("./models/user");
const os = require("os");
require("dotenv").config();

const getLocalIP = () => {
    const nets = os.networkInterfaces();
    let ipAddress = "localhost"; // Fallback to localhost

    for (const name of Object.keys(nets)) {
        for (const net of nets[name]) {
            // Skip over non-IPv4 and internal (i.e., 127.0.0.1) addresses
            if (net.family === "IPv4" && !net.internal) {
                ipAddress = net.address;
            }
        }
    }
    return ipAddress;
};

// Синхронизация моделей с базой данных
sequelize
    .sync()
    .then(() => console.log("Database synced"))
    .catch((err) => console.error("Database sync error:", err));

const authRoutes = require("./routes/auth");
const subscriptionRoutes = require("./routes/subscriptions");
const invoiceRoutes = require("./routes/invoice");
const dataRoutes = require("./routes/dataRoutes");

const app = express();

app.use(cors()); // Enable CORS
app.use(bodyParser.json());

app.use("/api", dataRoutes);
app.use("/api/auth", authRoutes);
app.use("/api/subscription", subscriptionRoutes);
app.use("/api/invoice", invoiceRoutes);

const PORT = 3000;

sequelize
    .sync()
    .then(() => {
        app.listen(PORT, () => {
            const localIP = getLocalIP();
            console.log(`Server is running on http://${localIP}:${PORT}`);
        });
    })
    .catch((error) => {
        console.error("Unable to connect to the database:", error);
    });
