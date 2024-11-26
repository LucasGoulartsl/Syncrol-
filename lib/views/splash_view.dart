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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Logo
          getShoppingCartLogo(
            width: 150,
            height: 150, 
          ),
          const SizedBox(height: 20), // Espaço entre a logo e o texto
          // Texto
          Text(
            'SYNCROL+',
            style: syncrolTextStyle().copyWith(
              fontSize: 30, // Ajuste o tamanho da fonte conforme necessário
            ),
          ),
          const SizedBox(height: 50), // Espaço entre o texto e a parte inferior
          // Alinha o loading na parte inferior da tela
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: 30.0), 
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 0, 0)), // Cor branca
              ),
            ),
          ),
        ],
      ),
    );
  }
}
