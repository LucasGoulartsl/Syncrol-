import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/views/control_validate_view.dart';
import 'package:my_project_flutter/views/export_view.dart';
import 'package:my_project_flutter/views/home_view.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController produtoController = TextEditingController();
  TextEditingController codigoController = TextEditingController();
  TextEditingController loteController = TextEditingController();
  TextEditingController precoUnitarioController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController validadeController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController marcaController = TextEditingController();

  List<Product> _product = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Produto"),
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: produtoController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do produto',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome do produto obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Campo para Código e Botões de Busca
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: codigoController,
                        decoration: const InputDecoration(
                          labelText: 'Código',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Código obrigatório.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () async {
                        // Busca manual com o código digitado
                        if (codigoController.text.isNotEmpty) {
                          await fetchProductInfo(codigoController.text);
                        }
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: scanBarcode, // Método para escanear
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: loteController,
                        decoration: const InputDecoration(
                          labelText: 'Lote',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lote obrigatório.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: precoUnitarioController,
                        decoration: const InputDecoration(
                          labelText: 'Preço Unitário',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preço unitário obrigatório.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: quantidadeController,
                        decoration: const InputDecoration(
                          labelText: 'Qntd',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Quantidade obrigatória.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: validadeController,
                        decoration: const InputDecoration(
                          labelText: 'Validade',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Data de validade obrigatória.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: categoriaController,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Categoria obrigatória.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: marcaController,
                        decoration: const InputDecoration(
                          labelText: 'Marca',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Marca obrigatória.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                FloatingActionButton(
                  backgroundColor: Colors.blue.shade200,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendData();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
      ),
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
        onUserPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ControlVali()),
          );
          //Ação para ir a validade
        },
        onStoragePressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ControlVali()),
          );
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

  Future<void> scanBarcode() async {
    try {
      String barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.BARCODE);

      if (barcode != "-1") {
        setState(() {
          codigoController.text = barcode;
        });

        // Consulta a API com o código escaneado
        await fetchProductInfo(barcode);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao escanear: $e')),
      );
    }
  }

  Future<void> fetchProductInfo(String barcode) async {
    final url = 'https://world.openfoodfacts.org/api/v0/product/$barcode.json';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final productData = json.decode(response.body);

        if (productData['status'] == 1) {
          // Produto encontrado
          final product = productData['product'];

          setState(() {
            produtoController.text =
                product['product_name'] ?? 'Produto desconhecido';
            marcaController.text = product['brands'] ?? 'Marca desconhecida';
            categoriaController.text =
                product['categories'] ?? 'Categoria desconhecida';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produto não encontrado na API.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erro ao buscar informações do produto.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  void sendData() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'produto': produtoController.text,
        'codigo': codigoController.text,
        'lote': loteController.text,
        'preco_unitario': precoUnitarioController.text,
        'quantidade': quantidadeController.text,
        'validade': validadeController.text,
        'categoria': categoriaController.text,
        'marca': marcaController.text,
      };

      try {
        final response = await http.post(
          Uri.parse('http://192.168.0.5:3000/postProduct'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Dados enviados com sucesso!')),
          );
          _fetchProducts();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao enviar dados: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro de conexão: $e')),
        );
      }
    }
  }

  Future<void> _fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.0.5:3000/getAllProducts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _product = data.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }
}

class Product {
  final String id;
  final String produto;
  final String codigo;
  final String lote;
  final String precoUnitario;
  final String quantidade;
  final String validade;
  final String categoria;
  final String marca;

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
