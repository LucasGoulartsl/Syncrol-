import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/register_view.dart';
import 'package:my_project_flutter/utils/text.styles.dart';
import 'home_view.dart';
import '../utils/logo_helper.dart'; // Importa a função getShoppingCartLogo
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage(); // Para armazenar o token

  Future<void> login(BuildContext context) async {
    final url = Uri.parse('http://localhost:3000/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String token = data['token'];

        // Armazenar o token em local seguro
        await storage.write(key: 'jwt_token', value: token);

        // Navegar para a home page após login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print('Erro ao se conectar: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao se conectar: ${response.body}')),
        );
      }
    } catch (error) {
      print('Erro ao se conectar ao backend: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
      ),
      backgroundColor: Colors.blue.shade200,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getShoppingCartLogo(width: 200, height: 200),
                const SizedBox(height: 20),
                Text(
                  'SYNCROL+',
                  style: syncrolTextStyle(),
                ),
                const SizedBox(height: 20),

                // Campo de entrada para usuário
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: inputDecoration('E-mail'),
                  ),
                ),

                // Campo de entrada para senha
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: inputDecoration('Senha'),
                    obscureText: true,
                  ),
                ),

                const SizedBox(height: 20),

                // Botão 'Entrar'
                ElevatedButton(
                  style: elevatedButtonStyle(Colors.blue.shade800),
                  onPressed: () {
                    login(context); // Chama a função de login
                  },
                  child: const Text('Entrar'),
                ),

                const SizedBox(height: 10),

                // Botão 'Registrar'
                ElevatedButton(
                  style: elevatedButtonStyle(Colors.blue.shade800),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
