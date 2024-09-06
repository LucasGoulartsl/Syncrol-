import 'package:flutter/material.dart';
import 'package:my_project_flutter/components/app_bar.dart';
import 'package:my_project_flutter/components/bottons_low.dart';
import 'package:my_project_flutter/views/add_product_view.dart';
import 'package:my_project_flutter/views/home_view.dart';

class ControlVali extends StatelessWidget {
  const ControlVali({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildOptionCard(
            icon: Icons.add_photo_alternate_outlined,
            text: 'Nome do produto',
            onTap: () {
              // Adicione a ação do onTap aqui
            },
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
              MaterialPageRoute(builder: (context) => const HomeScreen()), // Ação para o ícone para retornar a home
            );  
        },
        onStoragePressed: () {
          // Ação para o ícone de estoque
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        leading: Icon(icon, size: 40),
        title: Text(text, style: const TextStyle(fontSize: 18)),
        onTap: onTap,
      ),
    );
  }
}
