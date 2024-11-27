import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_project_flutter/model/environment.dart';
import 'package:my_project_flutter/views/login_view.dart';
import 'home_view.dart';
import '../utils/input_decoration.dart' as input_utils;
import '../utils/button_styles.dart' as button_utils;
import '../utils/text.styles.dart' as text_styles;
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Mapa para controlar os erros dos campos obrigatórios
  final Map<String, bool> _fieldErrors = {
    'name': false,
    'email': false,
    'password': false,
    'confirmPassword': false,
  };

  Future<void> register(BuildContext context) async {
    setState(() {
      // Valida se os campos estão vazios
      _fieldErrors['name'] = nameController.text.isEmpty;
      _fieldErrors['email'] = emailController.text.isEmpty;
      _fieldErrors['password'] = passwordController.text.isEmpty;
      _fieldErrors['confirmPassword'] = confirmPasswordController.text.isEmpty;
    });

    // Se algum campo obrigatório estiver vazio, não continua
    if (_fieldErrors.values.contains(true)) {
      return;
    }

    // Verifica se as senhas coincidem
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não coincidem')),
      );
      return;
    }

    final url = Uri.parse('${Environment.baseUrl}/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'confirmpassword': confirmPasswordController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        // Exibe erro no terminal
        print('Erro do backend: ${response.body}');
      }
    } catch (error) {
      // Exibe erro no terminal
      print('Erro ao se conectar ao backend: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
        backgroundColor: Colors.blue.shade200,
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Campo Nome
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: input_utils.inputDecoration('Nome de Usuário')
                        .copyWith(
                      errorText: (_fieldErrors['name'] ?? false)
                          ? 'O nome é obrigatório'
                          : null,
                      focusedBorder: (_fieldErrors['name'] ?? false)
                          ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                    ),
                  ),
                ),
                // Campo E-mail
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: input_utils.inputDecoration('E-mail').copyWith(
                      errorText: (_fieldErrors['email'] ?? false)
                          ? 'O e-mail é obrigatório'
                          : null,
                      focusedBorder: (_fieldErrors['email'] ?? false)
                          ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                // Campo Senha
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: input_utils.inputDecoration('Senha').copyWith(
                      errorText: (_fieldErrors['password'] ?? false)
                          ? 'A senha é obrigatória'
                          : null,
                      focusedBorder: (_fieldErrors['password'] ?? false)
                          ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                    ),
                    obscureText: true,
                  ),
                ),
                // Campo Confirmar Senha
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: confirmPasswordController,
                    decoration:
                        input_utils.inputDecoration('Confirmar Senha').copyWith(
                      errorText: (_fieldErrors['confirmPassword'] ?? false)
                          ? 'A confirmação de senha é obrigatória'
                          : null,
                      focusedBorder: (_fieldErrors['confirmPassword'] ?? false)
                          ? const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            )
                          : null,
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: button_utils.elevatedButtonStyle(Colors.blue.shade800),
                  onPressed: () {
                    register(context); // Chama a função de registro
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
