import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/app_bar.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/controller/control_validate_controller.dart';
import 'package:my_project_flutter/views/add_product_view.dart';
import 'package:my_project_flutter/views/control_stock_view.dart';
import 'package:my_project_flutter/views/export_view.dart';
import 'package:my_project_flutter/views/home_view.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ControlVali extends StatefulWidget {
  const ControlVali({super.key});

  @override
  _ControlValiState createState() => _ControlValiState();
}

class _ControlValiState extends State<ControlVali> {
  final ControlValidateController _controller = ControlValidateController();
  List<dynamic> _searchResults = [];
  List<dynamic> _allProducts = []; // Para armazenar todos os produtos

  void _search(String query) async {
    if (query.isNotEmpty) {
      final results = _allProducts.where((product) {
        return product['produto'].toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = _allProducts; // Resetar para todos os produtos se a pesquisa estiver vazia
      });
    }
  }

  void _fetchProducts() async {
    try {
      final results = await _controller.fetchExpiredAndNearExpiryProducts();
      setState(() {
        _allProducts = results; // Armazenar todos os produtos
        _searchResults = results; // Inicializar a lista de pesquisa
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar produtos: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Carrega os produtos na inicialização
  }

  List<dynamic> _sortProducts(List<dynamic> products) {
    products.sort((a, b) {
      DateTime expiryDateA = _parseDate(a['validade']);
      DateTime expiryDateB = _parseDate(b['validade']);

      
      if (expiryDateA.isBefore(DateTime.now()) && expiryDateB.isAfter(DateTime.now())) {
        return -1; 
      } else if (expiryDateA.isAfter(DateTime.now()) && expiryDateB.isBefore(DateTime.now())) {
        return 1; 
      } else {
        
        return expiryDateA.compareTo(expiryDateB);
      }
    });
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final sortedResults = _sortProducts(_searchResults); // Ordena os produtos para exibição

    return Scaffold(
      appBar: customAppBar(context: context, showUserButton: true), // Reutiliza o AppBar customizado
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                labelText: 'Procurar Produtos',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(child: Text("Nenhum produto encontrado"))
                : ListView.builder(
                    itemCount: sortedResults.length,
                    itemBuilder: (context, index) {
                      final product = sortedResults[index];
                      final borderColor = _controller.determineBorderColor(product['validade']);

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['produto'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Validade: ${product['validade']}'),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: customFloatingActionButton(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AddProductPage()),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomAppBar(
        onFloatingActionButtonPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AddProductPage()),
          );
        },
        onHomePressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()), // Ação para o ícone para retornar a home
          );
        },
        onStoragePressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ControlStock()), // Ação para o ícone para estoque
          );
        },
        onUserPressed: () {
          
        },
        onReportPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ExportScreen()),
          );
        },
      ),
    );
  }

  DateTime _parseDate(String dateString) {
    
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString); 
    } catch (e) {
      print('Erro ao converter a data de validade: $e');
      return DateTime.now();
    }
  }
}

class ControlValidateController {
  final String baseUrl = 'http://localhost:3000/expiredAndNearExpiryProducts';

  Future<List<dynamic>> fetchExpiredAndNearExpiryProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Erro HTTP: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao buscar produtos: $e');
      throw Exception('Falha ao carregar produtos: $e');
    }
  }

  DateTime _parseDate(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString); 
    } catch (e) {
      print('Erro ao converter a data de validade: $e');
      return DateTime.now();
    }
  }

  Color determineBorderColor(String validade) {
    final now = DateTime.now();
    final nextMonth = now.add(Duration(days: 30));
    final validadeDate = _parseDate(validade);

    if (validadeDate.isBefore(now)) {
      return Colors.red; 
    } else if (validadeDate.isBefore(nextMonth)) {
      return Colors.yellow; 
    } else {
      return Colors.green; 
    }
  }
}
