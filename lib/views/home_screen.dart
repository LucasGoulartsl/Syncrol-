import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
//Tela Registro
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à Tela Inicial!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}