const mongoose = require("mongoose");
const dotenv = require("dotenv");

dotenv.config();

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.MONGODB_URI, {});
    console.log("Sucesso ao conectar ao banco de dados!!");
  } catch (error) {
    console.error("Erro ao conectar ao MongoDB: ", error.message);
    process.exit(1);
  }
};

module.exports = connectDB;
