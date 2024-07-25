// controllers/dataController.js

exports.getData = (req, res) => {
    const sampleData = {
        name: "John Doe",
        email: "johndoe@example.com",
        address: "123 Main St, Anytown, USA",
        phone: "+1 (555) 123-4567",
        invoiceDate: "2023-07-23",
        dueDate: "2023-08-23",
        totalAmount: "$123.45",
        items: [
            { description: "Item 1", quantity: 1, price: "$50.00" },
            { description: "Item 2", quantity: 2, price: "$25.00" },
            { description: "Item 3", quantity: 3, price: "$10.00" },
        ],
    };

    res.json(sampleData);
};
