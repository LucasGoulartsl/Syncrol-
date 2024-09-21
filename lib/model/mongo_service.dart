import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  Db? db; // Adicione o ? para torná-la nula-segura
  DbCollection? productsCollection; // Adicione o ? para torná-la nula-segura

  static final MongoService _instance = MongoService._internal();

  factory MongoService() {
    return _instance;
  }

  MongoService._internal();

  // Método para conectar ao banco de dados MongoDB
  Future<void> connect() async {
    db = await Db.create('mongodb+srv://your_mongo_connection_string');
    await db!.open(); // Use o operador de verificação de nulidade
    productsCollection = db!.collection('products'); // Use o operador de verificação de nulidade
  }

  // Método para desconectar do banco de dados
  void disconnect() {
    db?.close(); // Use o operador de verificação de nulidade
  }

  // Busca produtos no MongoDB com base em um termo de busca
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final result = await productsCollection!.find({ // Use o operador de verificação de nulidade
      'name': RegExp(query, caseSensitive: false)
    }).toList();
    return result;
  }

  // Adiciona um produto ao banco de dados
  Future<void> addProduct(Map<String, dynamic> product) async {
    await productsCollection!.insertOne(product); // Use o operador de verificação de nulidade
  }

  // Remove um produto do banco de dados
  Future<void> removeProduct(String productId) async {
    await productsCollection!.deleteOne({'_id': ObjectId.fromHexString(productId)}); // Use o operador de verificação de nulidade
  }

  // Atualiza a quantidade de um produto
  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    await productsCollection!.updateOne(
      {'_id': ObjectId.fromHexString(productId)},
      ModifierBuilder().set('quantity', newQuantity)
    );
  }
}
