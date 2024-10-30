import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_project_flutter/views/home_view.dart'; // Importar sua tela inicial

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Funções para redirecionamento às redes sociais
  Future<void> _launchInstagram() async {
    final Uri url =
        Uri.parse('https://www.instagram.com/sampa.019'); // link do Instagram
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'suporte@email.com', // email
      query: 'subject=Contato pelo App', // Assunto do email
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Não foi possível enviar o email';
    }
  }

  Future<void> _launchTwitter() async {
    final Uri url = Uri.parse('https://twitter.com/'); // link do Twitter
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Icon(
              Icons.shopping_cart, // Seu ícone personalizado aqui
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            const Text(
              'Quem somos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Informações sobre o aplicativo e suas funcionalidades...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'Redes Sociais',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                      FontAwesomeIcons.instagram), // ícone do Instagram
                  onPressed: _launchInstagram,
                  iconSize: 40,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.email_outlined), // ícone do Gmail
                  onPressed: _launchEmail,
                  iconSize: 40,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon:
                      const Icon(FontAwesomeIcons.twitter), // ícone do Twitter
                  onPressed: _launchTwitter,
                  iconSize: 40,
                ),
              ],
            ),
            const Spacer(),
            const Text('Versão: 1.0.0'),
            const Text('Suporte: suporte@email.com'),
          ],
        ),
      ),
    );
  }
}
