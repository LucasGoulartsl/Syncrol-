import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/register_screen.dart';
import 'package:my_project_flutter/utils/text.styles.dart';
import 'home_screen.dart';
import '../utils/logo_helper.dart'; // Importa a função getShoppingCartLogo

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
      ),
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Adiciona o logo corretamente usando a função
              getShoppingCartLogo(width: 200, height: 200),

              // Espaço entre o logo e o texto
              const SizedBox(height: 20),

              // Texto 'Syncrol+'
              Text(
                'SYNCROL+',
                style: syncrolTextStyle(),
              ),

              // Espaço entre o texto e os campos de entrada
              const SizedBox(height: 20),

              // Campo de entrada para usuário
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: inputDecoration('Usuário'),
                ),
              ),

              // Campo de entrada para senha
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: inputDecoration('Senha'),
                  obscureText: true,
                ),
              ),

              // Espaço entre os campos de entrada e os botões
              const SizedBox(height: 20),

              // Botão 'Entrar'
              ElevatedButton(
                style: elevatedButtonStyle(Colors.blue.shade800),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text('Entrar'),
              ),

              // Espaço entre os botões
              const SizedBox(height: 10),

              // Botão 'Registrar'
              ElevatedButton(
                style: elevatedButtonStyle(Colors.blue.shade800),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
