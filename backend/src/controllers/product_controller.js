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

exports.getExpiredAndNearExpiryProducts = async (req, res) => {
  try {
    const today = new Date(); 
    today.setHours(0, 0, 0, 0); 

    const nextMonth = new Date(today);
    nextMonth.setDate(today.getDate() + 30); 

    const products = await Product.find(); 

    const updatedProducts = products.map((product) => {
      
      const validadeParts = product.validade.split('/');
      const validade = new Date(
        validadeParts[2], 
        validadeParts[1] - 1, 
        validadeParts[0] 
      );

      let status;
      if (validade < today) {
        status = "vencido"; 
      } else if (validade <= nextMonth) {
        status = "próximo"; 
      } else {
        status = "válido"; 
      }

      const validadeFormatada = `${validade.getDate().toString().padStart(2, '0')}/${(validade.getMonth() + 1).toString().padStart(2, '0')}/${validade.getFullYear()}`;

      return {
        ...product._doc,
        validade: validadeFormatada, 
        status,
      };
    });

    res.status(200).json(updatedProducts); 
  } catch (err) {
    res.status(500).json({ success: false, error: err.message });
  }
};
