import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/views/control_validate_view.dart';
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
          icon: const Icon(Icons.arrow_back), //Seta para voltar
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ); //Volta para a tela anterior
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
                //Nome do Produto
                TextFormField(
                  controller: produtoController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Nome do produto',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome do produto obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                //Código
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: codigoController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Código',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Código obrigatório.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: scanBarcode, //Chama o método para escanear
                      icon: const Icon(Icons.barcode_reader),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                //Lote e Preço Unitário
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: loteController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Lote',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Preço Unitário',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
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

                //Quantidade e Validade
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: quantidadeController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Qntd',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Validade',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
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

                //Categoria e Marca
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: categoriaController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Categoria',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
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
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Marca',
                          border: OutlineInputBorder(),
                        ),
                        validator: (String? value) {
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

                // Botão de Adicionar
                FloatingActionButton(
                  backgroundColor: Colors.blue.shade200,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendData(); //Função para enviar os dados
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 20),

                //Lista de produtos adicionados
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _product.length,
                  itemBuilder: (context, index) {
                    final product = _product[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.inventory_2_outlined),
                        title: Text(product.produto),
                        subtitle: Text(
                            'Código: ${product.codigo}\nLote: ${product.lote}\nPreço Unitário: ${product.precoUnitario}\nQuantidade: ${product.quantidade}\nValidade: ${product.validade}\nCategoria: ${product.categoria}\nMarca: ${product.marca}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () {
                            _deleteProduct(product);
                          },
                        ),
                      ),
                    );
                  },
                )
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
          //Ação para o ícone do usuário
        },
        onStoragePressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ControlVali()),
          );
        },
        onReportPressed: () {
          //Ação para o ícone de relatório
        },
      ),
    );
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
          Uri.parse('http://localhost:3000/postProduct'),
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
        await http.get(Uri.parse('http://localhost:3000/getAllProducts'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        _product = data.map((json) => Product.fromJson(json)).toList();
      });
    } else {
      throw Exception('Falha ao carregar produtos');
    }
  }

  Future<void> _deleteProduct(Product product) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:3000/deleteProduct/${product.id}'),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produto deletado com sucesso!')),
        );
        _fetchProducts(); //Atu a lista de produtos após excluir
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao deletar produto: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  Future<void> scanBarcode() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.BARCODE);

      if (result.isNotEmpty) {
        setState(() {
          codigoController.text = result;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao escanear: $e')),
      );
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
