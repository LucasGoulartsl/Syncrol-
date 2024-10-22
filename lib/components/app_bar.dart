import 'dart:ui_web';

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
        ? IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              
            },
          )
        : null,
    title: GestureDetector(
      onTap: () {
        // Navegar para a home screen ao clicar no título
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()), // Use a view da home
        );
      },
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    centerTitle: true,
    actions: <Widget>[
      if (showUserButton) // Corrigido aqui
        PopupMenuButton<String>(
          icon: const Icon(Icons.person),
          onSelected: (value) {
            if (value == 'sair') {
              // Ação para sair
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), // Navegar para a tela de login
              );
            } else if (value == 'fechar') {
            
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'sair',
                child: Text('Sair'),
              ),
              const PopupMenuItem<String>(
                value: 'fechar',
                child: Text('Fechar'),
              ),
            ];
          },
        ),
        
    ],
  );
}
