import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/about_view.dart';
import 'package:my_project_flutter/views/control_stock_view.dart';
import 'package:my_project_flutter/views/home_view.dart';
import 'package:my_project_flutter/views/control_validate_view.dart';
import 'package:my_project_flutter/views/export_view.dart';
import 'package:my_project_flutter/views/login_view.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 144, 202, 249),
            ),
            margin: EdgeInsets.zero, // Remove margens desnecessárias
            padding: EdgeInsets.zero, // Remove espaçamentos desnecessários
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/shopping_cart_logo.png'),
                    height: 80, // Ajuste o tamanho da logo
                  ),
                  SizedBox(height: 8), // Espaçamento entre a logo e o texto
                  Text(
                    'Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.verified_user),
                  title: const Text('Controle de Validade'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ControlVali()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('Controle de Estoque'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ControlStock()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('Exportar Dados'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExportScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
