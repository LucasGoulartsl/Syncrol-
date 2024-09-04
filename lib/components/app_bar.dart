// lib/utils/app_bar.dart

import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/login_screen.dart'; // Ajuste o caminho conforme necessário

AppBar customAppBar({
  required BuildContext context,
  String title = 'SYNCROL+',
  bool showMenuButton = true,
  bool showUserButton = true,
}) {
  return AppBar(
    backgroundColor: Colors.blue.shade200,
    leading: showMenuButton
        ? IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Ação para o menu
            },
          )
        : null,
    title: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    actions: <Widget>[
      if (showUserButton)
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
    ],
  );
}
