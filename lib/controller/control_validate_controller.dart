import 'package:my_project_flutter/model/mongo_service.dart';

class ControlValidateController {
  final MongoService _mongoService = MongoService();

  // Conectar ao MongoDB
  Future<void> connectToDb() async {
    await _mongoService.connect();
  }

  // Fechar a conexão com o MongoDB
  void closeConnection() {
    _mongoService.disconnect();
  }

  // Buscar produtos no banco de dados
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    return await _mongoService.searchProducts(query);
  }

  // Outras operações específicas de controle de validade podem ser adicionadas aqui
}
