const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    produto: {type: String, required: true,},
    codigo: {type: String, required: true,},
    lote: {type: String, required: true,},
    preco_unitario: {type: String, required: true,},
    quantidade: {type: String, required: true,},
    validade: {type: String, required: true,},
    categoria: {type: String, required: true,},
    marca: {type: String, required: true,},
});

const Product = mongoose.model('Product', productSchema);

module.exports = Product;