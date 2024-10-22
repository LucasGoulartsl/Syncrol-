import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/app_bar.dart'; // Importa o widget AppBar personalizado
import 'package:my_project_flutter/components/bottons_low.dart'; // Importa o widget BottomAppBar personalizado
import 'package:my_project_flutter/views/add_product_view.dart';
import 'package:my_project_flutter/views/control_stock_view.dart';
import 'package:my_project_flutter/views/control_validate_view.dart';
import 'package:my_project_flutter/views/login_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, showUserButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildOptionCard(
              icon: Icons.check_box,
              text: 'Controle de validade',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ControlVali()), // Ação ao clicar para direcionar a pagina de crontrole de validade
                );
              },
            ),
            const SizedBox(height: 20),
            _buildOptionCard(
              icon: Icons.inventory,
              text: 'Controle de estoque',
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const ControlStock()), // Ação ao clicar para direcionar a pagina de crontrole de estoque
                );
              },
            ),
          ],
        ),
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
          // Ação para o ícone de home
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
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, size: 40),
        title: Text(text, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}
