import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/app_bar.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/components/custom_drawer.dart';
import 'package:my_project_flutter/model/environment.dart';
import 'package:my_project_flutter/views/add_product_view.dart';
import 'package:my_project_flutter/views/control_validate_view.dart';
import 'package:my_project_flutter/views/export_view.dart';
import 'package:my_project_flutter/views/home_view.dart';
import 'package:my_project_flutter/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControlStock extends StatefulWidget {
  const ControlStock({super.key});

  @override
  _ControlStockState createState() => _ControlStockState();
}

class _ControlStockState extends State<ControlStock> {
  List<Product> _products = [];
  List<Product> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('${Environment.baseUrl}/getAllProducts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _products = data.map((json) => Product.fromJson(json)).toList();
        _searchResults = _products;
      });
    } else {
      throw Exception('Falha ao carregar produtos.');
    }
  }

  void _search(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _searchResults = _products
            .where((product) =>
                product.produto.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _searchResults = _products;
      });
    }
  }

  Future<void> _updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('${Environment.baseUrl}/putProduct/${product.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'produto': product.produto,
        'codigo': product.codigo,
        'lote': product.lote,
        'preco_unitario': product.precoUnitario,
        'quantidade': product.quantidade,
        'validade': product.validade,
        'categoria': product.categoria,
        'marca': product.marca,
      }),
    );

    if (response.statusCode == 200) {
      _fetchProducts();
    } else {
      throw Exception('Erro ao atualizar o produto.');
    }
  }

  Future<void> _deleteProduct(Product product) async {
    final response = await http.delete(
      Uri.parse('${Environment.baseUrl}/deleteProduct/${product.id}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _products.remove(product);
        _searchResults.remove(product);
      });
    } else {
      throw Exception('Erro ao deletar o produto.');
    }
  }

  void _showEditDialog(Product product) {
    TextEditingController produtoController =
        TextEditingController(text: product.produto);
    TextEditingController codigoController =
        TextEditingController(text: product.codigo);
    TextEditingController loteController =
        TextEditingController(text: product.lote);
    TextEditingController precoController =
        TextEditingController(text: product.precoUnitario);

    TextEditingController quantidadeController =
        TextEditingController(text: product.quantidade);
    TextEditingController validadeController =
        TextEditingController(text: product.validade);
    TextEditingController categoriaController =
        TextEditingController(text: product.categoria);
    TextEditingController marcaController =
        TextEditingController(text: product.marca);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Editar Produto"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: produtoController,
                  decoration:
                      const InputDecoration(labelText: "Nome do Produto"),
                ),
                TextField(
                  controller: codigoController,
                  decoration: const InputDecoration(labelText: "Código"),
                ),
                TextField(
                  controller: loteController,
                  decoration: const InputDecoration(labelText: "Lote"),
                ),
                TextField(
                  controller: precoController,
                  decoration:
                      const InputDecoration(labelText: "Preço Unitário"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: quantidadeController,
                  decoration: const InputDecoration(labelText: "Quantidade"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: validadeController,
                  decoration: const InputDecoration(labelText: "Validade"),
                ),
                TextField(
                  controller: categoriaController,
                  decoration: const InputDecoration(labelText: "Categoria"),
                ),
                TextField(
                  controller: marcaController,
                  decoration: const InputDecoration(labelText: "Marca"),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.delete,
                      color: Color.fromARGB(255, 0, 0, 0)),
                  onPressed: () async {
                    await _deleteProduct(product);
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                TextButton(
                  child: const Text("Cancelar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Salvar"),
                  onPressed: () async {
                    setState(() {
                      product.produto = produtoController.text;
                      product.codigo = codigoController.text;
                      product.lote = loteController.text;
                      product.precoUnitario = precoController.text;
                      product.quantidade = quantidadeController.text;
                      product.validade = validadeController.text;
                      product.categoria = categoriaController.text;
                      product.marca = marcaController.text;
                    });
                    await _updateProduct(product);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, showUserButton: true),
      drawer: const CustomDrawer(),
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
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final product = _searchResults[index];
                      return Card(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.produto,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Código: ${product.codigo}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        'Lote: ${product.lote}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        'Quantidade: ${product.quantidade}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        'Validade: ${product.validade}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                iconSize: 16.0,
                                onPressed: () => _showEditDialog(product),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text("Nenhum produto encontrado no estoque."),
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
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        onStoragePressed: () {
          // Voce ja ta no estoque
        },
        onUserPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ControlVali()),
          );
          // Ação para o ícone de validade
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
}
