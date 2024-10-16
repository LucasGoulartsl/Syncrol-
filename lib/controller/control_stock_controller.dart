import 'package:my_project_flutter/model/mongo_service.dart';

class ControlStockController {
  final MongoService _mongoService = MongoService();

  // Buscar produtos no estoque
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    return await _mongoService.searchProducts(query);
  }

  // Adicionar um novo produto ao estoque
  Future<void> addProduct(Map<String, dynamic> product) async {
    await _mongoService.addProduct(product);
  }

  // Atualizar quantidade de produto no estoque
  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    await _mongoService.updateProductQuantity(productId, newQuantity);
  }

  // Remover produto do estoque
  Future<void> removeProduct(String productId) async {
    await _mongoService.removeProduct(productId);
  }
}
