import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/app_bar.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/controller/control_validate_controller.dart';
import 'package:my_project_flutter/views/add_product_view.dart';
import 'package:my_project_flutter/views/control_stock_view.dart';
import 'package:my_project_flutter/views/home_view.dart';

class ControlVali extends StatefulWidget {
  const ControlVali({super.key});

  @override
  _ControlValiState createState() => _ControlValiState();
}

class _ControlValiState extends State<ControlVali> {
  final ControlValidateController _controller = ControlValidateController();
  List<Map<String, dynamic>> _searchResults = [];

  void _search(String query) async {
    if (query.isNotEmpty) {
      final results = await _controller.searchProducts(query);
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
        appBar:
            customAppBar(context: context, showUserButton: true), // Reutiliza o AppBar customizado
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
              child: _searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final product = _searchResults[index];
                        return ListTile(
                          title: Text(product['name']),
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
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
          // Ação para o botão flutuante
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
              MaterialPageRoute(
                  builder: (context) =>
                      const HomeScreen()), // Ação para o ícone para retornar a home
            );
          },
          onStoragePressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ControlStock()), // Ação para o ícone para estoque
            );
          },
          onUserPressed: () {
            // Ação para o ícone de usuário
          },
          onReportPressed: () {
            // Ação para o ícone de relatório
          },
        ));
  }
}
