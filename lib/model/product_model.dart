class Product {
  String id;
  String produto;
  String codigo;
  String lote;
  String precoUnitario;
  String quantidade;
  String validade;
  String categoria;
  String marca;

  Product({
    required this.id,
    required this.produto,
    required this.codigo,
    required this.lote,
    required this.precoUnitario,
    required this.quantidade,
    required this.validade,
    required this.categoria,
    required this.marca,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      produto: json['produto'],
      codigo: json['codigo'],
      lote: json['lote'],
      precoUnitario: json['preco_unitario'],
      quantidade: json['quantidade'],
      validade: json['validade'],
      categoria: json['categoria'],
      marca: json['marca'],
    );
  }
}