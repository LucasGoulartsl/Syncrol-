// app.js
require("dotenv").config();
const express = require("express");
const cors = require("cors");
const connectDB = require("./src/config/database");
const productRoute = require("./src/routes/product_route");
const userRoute = require("./src/routes/user_route");

const app = express();
connectDB();

// Config JSON response
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());

// Rota pública - Página inicial
app.get("/", (req, res) => {
  res.status(200).json({ msg: "Bem-vindo!" });
});

// Rotas
app.use("/", productRoute);
app.use("/", userRoute);

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send("Algo deu errado.");
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});