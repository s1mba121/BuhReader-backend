// controllers/invoiceController.js
const Invoice = require("../models/invoice");
const Subscription = require("../models/subscription");
const fs = require("fs");
const path = require("path");
const pdf = require("pdf-parse");
const axios = require("axios");
const pdfPoppler = require("pdf-poppler");
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

// Function to convert PDF to image
async function convertPDFToImage(pdfPath) {
    try {
        const outputDir = path.dirname(pdfPath);
        const outputPath = path.join(
            outputDir,
            path.basename(pdfPath, path.extname(pdfPath))
        );

        const opts = {
            format: "jpeg",
            out_dir: outputDir,
            out_prefix: path.basename(pdfPath, path.extname(pdfPath)),
            page: null,
        };

        await pdfPoppler.convert(pdfPath, opts);
        return `${outputPath}-1.jpg`;
    } catch (error) {
        console.error("Error converting PDF to image:", error.message);
        throw new Error("Error converting PDF to image");
    }
}

// Function to encode image to base64
function encodeImage(imagePath) {
    const imageBuffer = fs.readFileSync(imagePath);
    return imageBuffer.toString("base64");
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

// Function to extract data from image using OpenAI API
async function extractDataFromImage(imagePath) {
    try {
        const base64Image = encodeImage(imagePath);
        const response = await axios.post(
            apiUrl,
            {
                model: "gpt-4o-mini",
                messages: [
                    {
                        role: "user",
                        content: [
                            {
                                type: "text",
                                text: "The image appears to be a receipt, likely for a purchase made at a store or service. It contains various details, including the date, an itemized list of purchases, the total amount, VAT (value-added tax), and other transaction information. Extract the following data in the format DATA:Numer Faktury;Data;Nazwa klienta;NIP klienta;Wartość netto;VAT;Wartość VAT;Wartość brutto, followed by items in the format ITEM:Nazwa towaru/usługi;Ilość;J.m.;Cena netto;Wartość netto;VAT;Kwota VAT;Wartość brutto:",
                            },
                            {
                                type: "image_url",
                                image_url: {
                                    url: `data:image/jpeg;base64,${base64Image}`,
                                },
                            },
                        ],
                    },
                ],
                max_tokens: 300,
            },
            {
                headers: {
                    Authorization: `Bearer ${openaiApiKey}`,
                    "Content-Type": "application/json",
                },
            }
        );

        const imageDescription =
            response.data.choices[0].message.content.trim();
        console.log("Image Description:", imageDescription);

        const dataExtractionPrompt = `
            The image appears to be a receipt, likely for a purchase made at a store or service. It contains various details, including the date, an itemized list of purchases, the total amount, VAT (value-added tax), and other transaction information. 
            Extract the following data in the format DATA:Numer Faktury;Data;Nazwa klienta;NIP klienta;Wartość netto;VAT;Wartość VAT;Wartość brutto, followed by items in the format ITEM:Nazwa towaru/usługi;Ilość;J.m.;Cena netto;Wartość netto;VAT;Kwota VAT;Wartość brutto:
        `;

        return extractDataFromDocument(
            `${imageDescription}\n${dataExtractionPrompt}`
        );
    } catch (error) {
        console.error("Error extracting data from image:", error.message);
        throw new Error("Error extracting data from image");
    }
}

// Main function to process PDF file
async function extractDataFromPDF(pdfPath) {
    try {
        const textData = await extractTextFromPDF(pdfPath);
        return await extractDataFromDocument(textData);
    } catch (error) {
        console.error(
            "Failed to extract text from PDF, converting to image..."
        );

        const jpgPath = await convertPDFToImage(pdfPath);
        return extractDataFromImage(jpgPath);
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

        if (!req.files || req.files.length === 0) {
            return res.status(400).json({ error: "No files uploaded" });
        }

        const extractedDataArray = [];

        for (const file of req.files) {
            const pdfPath = file.path;

            try {
                let extractedData = await extractDataFromPDF(pdfPath);
                console.log("Extracted Data:", extractedData);

                // Check if key fields are empty
                if (
                    !extractedData.date ||
                    !extractedData.clientName ||
                    !extractedData.clientNIP ||
                    !extractedData.netValue ||
                    !extractedData.vatRate ||
                    !extractedData.vatValue ||
                    !extractedData.grossValue
                ) {
                    console.log(
                        "Key fields are empty, converting PDF to image..."
                    );
                    const jpgPath = await convertPDFToImage(pdfPath);
                    extractedData = await extractDataFromImage(jpgPath);
                }

                console.log("Sending Extracted Data:", extractedData);
                extractedDataArray.push(extractedData);
            } catch (error) {
                console.error(
                    "Failed to extract data from PDF:",
                    error.message
                );
                return res
                    .status(500)
                    .json({ error: "Failed to extract data from PDF" });
            }
        }

        res.status(201).json({ data: extractedDataArray });
    } catch (error) {
        console.error("Failed to read invoice:", error.message);
        res.status(500).json({ error: "Failed to read invoice" });
    }
};
