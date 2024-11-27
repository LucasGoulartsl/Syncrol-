import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_project_flutter/views/home_view.dart'; // Substitua pelo caminho correto da sua tela inicial

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Função para redirecionar ao Instagram
  Future<void> _launchInstagram(BuildContext context) async {
    final Uri url = Uri.parse('https://www.instagram.com/sampa.019');
    try {
      bool launched =
          await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched) {
        throw 'Não foi possível abrir $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o Instagram.'),
        ),
      );
    }
  }

  // Função para redirecionar ao e-mail
  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'suporte@email.com',
      query: 'subject=Contato pelo App',
    );
    try {
      bool launched =
          await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      if (!launched) {
        throw 'Não foi possível enviar o email';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível enviar o email.'),
        ),
      );
    }
  }

  // Função para redirecionar ao Twitter
  Future<void> _launchTwitter(BuildContext context) async {
    final Uri url = Uri.parse('https://twitter.com/');
    try {
      bool launched =
          await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched) {
        throw 'Não foi possível abrir $url';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não foi possível abrir o Twitter.'),
        ),
      );
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
              Icons.shopping_cart,
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
                  icon: const Icon(FontAwesomeIcons.instagram),
                  onPressed: () => _launchInstagram(context),
                  iconSize: 40,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.email_outlined),
                  onPressed: () => _launchEmail(context),
                  iconSize: 40,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.twitter),
                  onPressed: () => _launchTwitter(context),
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
