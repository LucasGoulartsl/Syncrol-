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

      // Primeiro, produtos vencidos
      if (expiryDateA.isBefore(DateTime.now()) && expiryDateB.isAfter(DateTime.now())) {
        return -1; // A vem antes de B
      } else if (expiryDateA.isAfter(DateTime.now()) && expiryDateB.isBefore(DateTime.now())) {
        return 1; // B vem antes de A
      } else {
        // Se ambos estão vencidos ou próximos a vencer, ordenar por data
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
            child: sortedResults.isNotEmpty
                ? ListView.builder(
                    itemCount: sortedResults.length,
                    itemBuilder: (context, index) {
                      final product = sortedResults[index];
                      return ListTile(
                        title: Text(product['produto']),
                        subtitle: Text('Validade: ${product['validade']}'),
                      );
                    },
                  )
                : const Center(
                    child: Text("Nenhum produto encontrado"),
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
          // Voce ja ta na validade
        },
        onReportPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ExportScreen()),
          );
          // Ação para o ícone de relatório
        },
      ),
    );
  }

  DateTime _parseDate(String dateString) {
    // Lógica de conversão de data
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      print('Erro ao converter a data de validade: $e');
      return DateTime.now();
    }
  }
}

class ControlValidateController {
  final String baseUrl = 'http://192.168.0.5:3000/expiredAndNearExpiryProducts'; 
  Future<List<dynamic>> fetchExpiredAndNearExpiryProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erro HTTP: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Erro ao buscar produtos: $e');
      throw Exception('Falha ao carregar produtos: $e');
    }
  }
}
