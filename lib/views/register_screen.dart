import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/login_screen.dart';
import 'home_screen.dart';
import '../utils/input_decoration.dart' as input_utils;
import '../utils/button_styles.dart' as button_utils;
import '../utils/text.styles.dart' as text_styles;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
        backgroundColor: Colors.blue.shade200,

        // Botão de retornar para a tela de login
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo de entrada para nome de usuário
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: input_utils.inputDecoration('Nome de Usuário'),
                ),
              ),

              // Campo de entrada para e-mail
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: input_utils.inputDecoration('E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),

              // Campo de entrada para senha
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: input_utils.inputDecoration('Senha'),
                  obscureText: true,
                ),
              ),

              // Campo de entrada para confirmar senha
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: input_utils.inputDecoration('Confirmar Senha'),
                  obscureText: true,
                ),
              ),

              // Espaço entre os campos de entrada e o botão
              const SizedBox(height: 20),

              // Botão 'Registrar'
              ElevatedButton(
                style: button_utils.elevatedButtonStyle(Colors.green.shade600),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
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
