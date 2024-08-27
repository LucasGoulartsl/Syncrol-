import 'package:flutter/material.dart';
import 'package:my_project_flutter/views/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
//Home page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syncrol+'),
        centerTitle: true,
        //Botão de perfil
        actions: <Widget>[
          IconButton(
            icon:const Icon(Icons.person),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            ),
            ],
            backgroundColor:  const Color.fromARGB(255, 63, 180, 67),
      ),
      //Botão de menu a esquerda
      drawer: Drawer(),
    );
  }
}