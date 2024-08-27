import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:my_project_flutter/views/login_screen.dart';
import '../logo_helper.dart'; // Adicione esta linha para importar a função getShoppingCartLogo

// Tela Apresentacao
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      title: const Text(
        'Syncrol+',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
      logo: getShoppingCartLogo(
          width: 200, height: 200), // Usa a função para obter a imagem
      backgroundColor: const Color.fromARGB(255, 63, 180, 67),
      showLoader: true,
      durationInSeconds: 3,
      navigator: const LoginScreen(),
    );
  }
}
