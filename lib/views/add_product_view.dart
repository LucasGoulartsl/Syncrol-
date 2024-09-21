import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/views/control_validate_view.dart';
import 'package:my_project_flutter/views/home_view.dart';

class AddProductPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController loteController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController validadeController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController brandController = TextEditingController();

  AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Produto"),
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Nome do Produto
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome do produto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Código
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: codeController,
                      decoration: const InputDecoration(
                        labelText: 'Código',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.qr_code_scanner),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Lote e Preço Unitário
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: loteController,
                      decoration: const InputDecoration(
                        labelText: 'Lote',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Preço Unitário',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Quantidade e Validade
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Qntd',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: validadeController,
                      decoration: const InputDecoration(
                        labelText: 'Validade',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Categoria e Marca
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: brandController,
                      decoration: const InputDecoration(
                        labelText: 'Marca',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Botão de Adicionar
              FloatingActionButton(
                backgroundColor: Colors.blue.shade200,
                onPressed: () {
                  // Aqui adicionaremos a lógica de salvar o produto
                },
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 20),

              // Produtos Adicionados (Exemplo de listagem)
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.inventory_2_outlined),
                      title: Text('Nome do Produto'),
                      subtitle:
                          Text('Cod. Lote: xxxxxxxxx\nValidade: 00/00/0000'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.inventory_2_outlined),
                      title: Text('Nome do Produto'),
                      subtitle:
                          Text('Cod. Lote: xxxxxxxxx\nValidade: 00/00/0000'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
                    const ControlVali()), // Ação para o ícone para retornar a home
          );
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
