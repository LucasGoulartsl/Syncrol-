import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/login_view.dart';
import 'package:my_project_flutter/utils/text.styles.dart';
import '../utils/logo_helper.dart'; // Importa a função getShoppingCartLogo

// Tela Apresentacao
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navega para a tela de login após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200, // Cor de fundo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Logo
            getShoppingCartLogo(
              width: 150, // Ajuste o tamanho da logo conforme necessário
              height: 150, // Ajuste o tamanho da logo conforme necessário
            ),
            const SizedBox(height: 20), // Espaço entre a logo e o texto
            // Texto
            Text(
              'SYNCROL+',
              style: syncrolTextStyle().copyWith(
                fontSize: 30, // Ajuste o tamanho da fonte conforme necessário
              ),
            ),
          ],
        ),
      ),
    );
  }
}
