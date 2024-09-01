import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/login_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Ação para o menu
          },
        ),
        title: Text('SYNCROL+', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.pushReplacement (context,
               MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildOptionCard(
              icon: Icons.check_box,
              text: 'Controle de validade',
              onTap: () {
                // Ação ao clicar
              },
            ),
            SizedBox(height: 20),
            _buildOptionCard(
              icon: Icons.inventory,
              text: 'Controle de estoque',
              onTap: () {
                // Ação ao clicar
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ação para o botão flutuante
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Ação para o ícone de home
              },
            ),
            IconButton(
              icon: Icon(Icons.storage),
              onPressed: () {
                // Ação para o ícone de estoque
              },
            ),
            SizedBox(width: 40), // Espaço para o FloatingActionButton
            IconButton(
              icon: Icon(Icons.verified_user),
              onPressed: () {
                // Ação para o ícone de usuário
              },
            ),
            IconButton(
              icon: Icon(Icons.assignment),
              onPressed: () {
                // Ação para o ícone de relatório
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({required IconData icon, required String text, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, size: 40),
        title: Text(text, style: TextStyle(fontSize: 18)),
        trailing: Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }
}