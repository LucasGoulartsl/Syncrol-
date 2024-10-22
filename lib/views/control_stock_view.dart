import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/app_bar.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/controller/control_stock_controller.dart'; // Alterado o controller para o controle de estoque
import 'package:my_project_flutter/views/add_product_view.dart';
import 'package:my_project_flutter/views/home_view.dart';

class ControlStock extends StatefulWidget { // Nome alterado para ControlStock
  const ControlStock({super.key});

  @override
  _ControlStockState createState() => _ControlStockState();
}

class _ControlStockState extends State<ControlStock> {
  final ControlStockController _controller = ControlStockController(); // Usando o controlador de estoque
  List<Map<String, dynamic>> _searchResults = [];
  
  void _search(String query) async {
    if (query.isNotEmpty) {
      final results = await _controller.searchProducts(query); // Função de busca no estoque
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, showUserButton: true), // Reutiliza o AppBar customizado
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                labelText: 'Procurar no Estoque',
                suffixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final product = _searchResults[index];
                      return ListTile(
                        title: Text(product['name']),
                        subtitle: Text('Quantidade: ${product['quantity']}'), // Exibe a quantidade do estoque
                      );
                    },
                  )
                : const Center(
                    child: Text("Nenhum produto encontrado no estoque"),
                  ),
          ),
        ],
      ),
      floatingActionButton: customFloatingActionButton(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddProductPage()),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomAppBar(
        onFloatingActionButtonPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        onHomePressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        onStoragePressed: () {
          // Voce ja esta no estoque !!
        },
        onUserPressed: () {
          // Ação para o ícone de usuário
        },
        onReportPressed: () {
          // Ação para o ícone de relatório
        },
      ),
    );
  }
}
