// controllers/invoiceController.js
const Invoice = require("../models/invoice");
const Subscription = require("../models/subscription");
const fs = require("fs");
const path = require("path");
const pdf = require("pdf-parse");
const axios = require("axios");
require("dotenv").config();

const openaiApiKey = process.env.OPENAI_API_KEY;
const apiUrl = "https://api.openai.com/v1/chat/completions";

// Функция для конвертации PDF в текст
async function extractTextFromPDF(pdfPath) {
    try {
        const dataBuffer = fs.readFileSync(pdfPath);
        const data = await pdf(dataBuffer);
        return data.text;
    } catch (error) {
        console.error("Error extracting text from PDF:", error.message);
        throw new Error("Error extracting text from PDF");
    }
}

// Функция для извлечения данных из текста с помощью OpenAI API
async function extractDataFromDocument(textData) {
    try {
        const response = await axios.post(
            apiUrl,
            {
                model: "gpt-3.5-turbo",
                messages: [
                    {
                        role: "system",
                        content: "You are a helpful assistant.",
                    },
                    {
                        role: "user",
                        content:
                            "Extract the following data in the format DATA:Numer Faktury;Data;Nazwa klienta;NIP klienta;Wartość netto;VAT;Wartość VAT;Wartość brutto, followed by items in the format ITEM:Nazwa towaru/usługi;Ilość;J.m.;Cena netto;Wartość netto;VAT;Kwota VAT;Wartość brutto:",
                    },
                    {
                        role: "user",
                        content: textData,
                    },
                ],
                max_tokens: 1000,
                temperature: 0.5,
            },
            {
                headers: {
                    Authorization: `Bearer ${openaiApiKey}`,
                    "Content-Type": "application/json",
                },
            }
        );

        const extractedText = response.data.choices[0].message.content.trim();
        console.log("Extracted Data:", extractedText);

        const [headerLine, ...itemLines] = extractedText.split("\n");
        const headerParts = headerLine.replace("DATA:", "").split(";");
        const items = itemLines.map((line) => {
            const parts = line.replace("ITEM:", "").split(";");
            return {
                name: parts[0],
                quantity: parts[1],
                unit: parts[2],
                netPrice: parts[3],
                netValue: parts[4],
                vatRate: parts[5],
                vatValue: parts[6],
                grossValue: parts[7],
            };
        });

        return {
            number: headerParts[0],
            date: headerParts[1],
            clientName: headerParts[2],
            clientNIP: headerParts[3],
            netValue: headerParts[4],
            vatRate: headerParts[5],
            vatValue: headerParts[6],
            grossValue: headerParts[7],
            items,
        };
    } catch (error) {
        console.error("Error extracting data from document:", error.message);
        throw new Error("Error extracting data from document");
    }
}

// Основная функция для обработки PDF файла
async function extractDataFromPDF(pdfPath) {
    try {
        const textData = await extractTextFromPDF(pdfPath);
        const extractedData = await extractDataFromDocument(textData);
        return extractedData;
    } catch (error) {
        console.error("Error processing PDF:", error.message);
        throw new Error("Error processing PDF");
    }
}

exports.readInvoice = async (req, res) => {
    const userId = req.user.userId;

    if (!userId) {
        console.error("userId is not defined");
        return res.status(400).json({ error: "User ID is required" });
    }

    try {
        const userInvoices = await Invoice.count({
            where: { user_id: userId },
        });

        const subscription = await Subscription.findOne({
            where: { user_id: userId },
        });

        if (!subscription && userInvoices >= 5) {
            return res
                .status(400)
                .json({ error: "Reading limit reached. Please subscribe." });
        }

        if (subscription) {
            const now = new Date();
            if (
                subscription.plan === "Lite" &&
                now > subscription.expiry_date
            ) {
                return res
                    .status(400)
                    .json({ error: "Subscription expired. Please renew." });
            }

            if (subscription.plan === "Lite" && userInvoices >= 100) {
                return res
                    .status(400)
                    .json({ error: "Monthly limit reached. Upgrade to Pro." });
            }
        }

        if (!req.file) {
            return res.status(400).json({ error: "No file uploaded" });
        }

        const pdfPath = req.file.path;

        try {
            const extractedData = await extractDataFromPDF(pdfPath);
            console.log("Sending Extracted Data:", extractedData);
            res.status(201).json({ data: extractedData });
        } catch (error) {
            console.error("Failed to extract data from PDF:", error.message);
            res.status(500).json({ error: "Failed to extract data from PDF" });
        }
    } catch (error) {
        console.error("Failed to read invoice:", error.message);
        res.status(500).json({ error: "Failed to read invoice" });
    }
};
