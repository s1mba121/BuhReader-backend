const multer = require("multer");
const path = require("path");

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, path.join(__dirname, "..", "uploads")); // Корректный путь к папке uploads
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + path.extname(file.originalname)); // Имя файла с текущим временем
    },
});

const upload = multer({ storage: storage });

module.exports = upload;
