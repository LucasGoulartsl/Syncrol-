import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/login_view.dart'; // Ajuste o caminho conforme necessário
import 'package:my_project_flutter/views/home_view.dart'; // Importar a view da home

AppBar customAppBar({
  required BuildContext context,
  String title = 'SYNCROL+',
  bool showMenuButton = true,
  required bool showUserButton,
}) {
  return AppBar(
    backgroundColor: Colors.blue.shade200,
    leading: showMenuButton
        ? Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Abre o drawer ao clicar no ícone do menu
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          )
        : null,
    title: GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      },
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    centerTitle: true,
    actions: <Widget>[
      if (showUserButton)
        PopupMenuButton<String>(
          icon: const Icon(Icons.person),
          onSelected: (value) {
            if (value == 'sair') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(value: 'sair', child: Text('Sair')),
              const PopupMenuItem<String>(
                  value: 'fechar', child: Text('Fechar')),
            ];
          },
        ),
    ],
  );
}
