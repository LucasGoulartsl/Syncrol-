import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_project_flutter/model/environment.dart';
import 'package:my_project_flutter/views/register_view.dart';
import 'package:my_project_flutter/views/forgot_password.dart'; // Importa a tela de recuperação de senha
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
    // Verifica se os campos de e-mail e senha estão vazios
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _showErrorDialog(context, 'Campos de e-mail e senha não podem estar vazios.');
      return; // Não faz a requisição se os campos estiverem vazios
    }

    final url = Uri.parse('${Environment.baseUrl}/auth/login');

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
      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        _showErrorDialog(context, data['msg']);
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        _showErrorDialog(context, data['msg']);
      } else {
        _showErrorDialog(context, 'Erro desconhecido. Tente novamente.');
      }
    } catch (error) {
      print('Erro ao se conectar ao backend: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $error')),
      );
    }
  }

  // Função para mostrar o pop-up de erro
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o pop-up
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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

                // Link "Esqueci a Senha?"
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordView(),
                      ),
                    );
                  },
                  child: const Text(
                    'Esqueci a Senha?',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // Botão 'Entrar'
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue.shade800),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  onPressed: () {
                    login(context); // Chama a função de login
                  },
                  child: const Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),

                // Botão 'Registrar'
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue.shade800),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Registrar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
