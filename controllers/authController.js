// controllers/authController.js
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const nodemailer = require("nodemailer");
const User = require("../models/user");
const { v4: uuidv4 } = require("uuid");
require("dotenv").config();

const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: process.env.EMAIL,
        pass: process.env.EMAIL_PASSWORD,
    },
});

exports.register = async (req, res) => {
    const { email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);
    const verification_code = uuidv4().slice(0, 6);

    try {
        const user = await User.create({
            email,
            password: hashedPassword,
            verification_code,
        });

        const mailOptions = {
            from: process.env.EMAIL,
            to: email,
            subject: "Email Verification",
            text: `Your verification code is ${verification_code}`,
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.error("Failed to send email:", error);
                return res.status(500).json({ error: "Failed to send email" });
            }
            res.status(201).json({
                message: "User registered. Please verify your email.",
            });
        });
    } catch (error) {
        console.error("Error registering user:", error);
        res.status(500).json({ error: "Failed to register user" });
    }
};

exports.verify = async (req, res) => {
    const { email, verification_code } = req.body;

    try {
        const user = await User.findOne({ where: { email } });

        if (user) {
            if (user.verification_code === verification_code) {
                user.is_verified = true;
                user.verification_code = null;
                await user.save();
                res.status(200).json({
                    message: "Email verified successfully",
                });
            } else {
                res.status(400).json({ error: "Invalid verification code" });
            }
        } else {
            res.status(400).json({ error: "User not found" });
        }
    } catch (error) {
        console.error("Error verifying email:", error);
        res.status(500).json({ error: "Failed to verify email" });
    }
};

exports.login = async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ where: { email } });

        if (!user) {
            return res.status(400).json({ error: "User not found" });
        }

        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) {
            return res.status(400).json({ error: "Invalid credentials" });
        }

        const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET, {
            expiresIn: "1h",
        });

        res.status(200).json({ token, userId: user.id });
    } catch (error) {
        console.error("Error logging in user:", error);
        res.status(500).json({ error: "Failed to login user" });
    }
};

exports.resetPasswordRequest = async (req, res) => {
    const { email } = req.body;
    const reset_code = uuidv4().slice(0, 6);

    try {
        const user = await User.findOne({ where: { email } });

        if (!user) {
            return res.status(400).json({ error: "User not found" });
        }

        user.reset_code = reset_code;
        await user.save();

        const mailOptions = {
            from: process.env.EMAIL,
            to: email,
            subject: "Password Reset",
            text: `Your password reset code is ${reset_code}`,
        };

        transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
                console.error("Failed to send email:", error);
                return res.status(500).json({ error: "Failed to send email" });
            }
            res.status(200).json({ message: "Reset code sent to email" });
        });
    } catch (error) {
        console.error("Error sending reset code:", error);
        res.status(500).json({ error: "Failed to send reset code" });
    }
};

exports.resetPassword = async (req, res) => {
    const { email, reset_code, new_password } = req.body;

    try {
        const user = await User.findOne({ where: { email } });

        if (user && user.reset_code === reset_code) {
            const hashedPassword = await bcrypt.hash(new_password, 10);
            user.password = hashedPassword;
            user.reset_code = null;
            await user.save();
            res.status(200).json({ message: "Password reset successfully" });
        } else {
            res.status(400).json({ error: "Invalid reset code" });
        }
    } catch (error) {
        console.error("Error resetting password:", error);
        res.status(500).json({ error: "Failed to reset password" });
    }
};
