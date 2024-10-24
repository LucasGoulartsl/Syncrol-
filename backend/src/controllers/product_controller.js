const Product = require("../models/product_model");
const connectDB = require("../config/database");

exports.postProduct = async (req, res) => {
  const {
    produto,
    codigo,
    lote,
    preco_unitario,
    quantidade,
    validade,
    categoria,
    marca,
  } = req.body;

  try {
    const newProduct = new Product({
      produto,
      codigo,
      lote,
      preco_unitario,
      quantidade,
      validade,
      categoria,
      marca,
    });
    const result = await newProduct.save();
    res.json({ success: true, insertId: result._id });
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.find();
    res.status(200).json(products);
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};

exports.putProduct = async (req, res) => {
  try {
    const {
      produto,
      codigo,
      lote,
      preco_unitario,
      quantidade,
      validade,
      categoria,
      marca,
    } = req.body;
    const updateProduct = await Product.findByIdAndUpdate(
      req.params.id,
      {
        produto,
        codigo,
        lote,
        preco_unitario,
        quantidade,
        validade,
        categoria,
        marca,
      },
      { new: true }
    );

    if (!updateProduct) {
      return res.status(404).json({ message: "Produto não encontrado." });
    }
    res.status(200).json({
      message: "Produto atualizado com sucesso.",
      product: updateProduct,
    });
  } catch (error) {
    res.status(500).json({ message: "Erro ao atualizar o produto.", error });
  }
};

exports.deleteProduct = async (req, res) => {
  try {
    const product = await Product.findByIdAndDelete(req.params.id);
    if (!product) {
      return res.status(404).json({ message: "Produto não encontrado." });
    }
    res.status(200).json({ message: "Produto deletado com sucesso." });
  } catch (error) {
    res.status(500).json({ message: "Erro ao deletar produto.", error });
  }
};
