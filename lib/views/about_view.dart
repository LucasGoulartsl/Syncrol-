import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  // Funções para redirecionamento às redes sociais
  void _launchInstagram() async {
    const url =
        'https://www.instagram.com/sampa.019'; //link do Instagram
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'lukasoliveiraoficial55@gmail.com', //  email
      query: 'subject=Contato pelo App', // Assunto do email
    );
    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      throw 'Não foi possível enviar o email';
    }
  }

  void _launchTwitter() async {
    const url = 'https://twitter.com/seu_perfil'; //link do Twitter
    if (await canLaunch(url)) {
      await launch(url);
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
                      Icons.camera_alt_outlined), // ícone do Instagram
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
                  icon: const Icon(Icons.message), // ícone do Twitter
                  onPressed: _launchTwitter,
                  iconSize: 40,
                ),
              ],
            ),
            const Spacer(),
            const Text('Version: 1.0.0'),
            const Text('Suporte: suporte@seuemail.com'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(icon: const Icon(Icons.storage), onPressed: () {}),
            const SizedBox(width: 40), // Espaço para o FloatingActionButton
            IconButton(icon: const Icon(Icons.verified_user), onPressed: () {}),
            IconButton(icon: const Icon(Icons.assignment), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
