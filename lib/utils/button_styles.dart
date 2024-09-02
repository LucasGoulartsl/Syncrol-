import 'package:flutter/material.dart';

ButtonStyle elevatedButtonStyle(Color backgroundColor) {
  return ElevatedButton.styleFrom(
    foregroundColor: Colors.white, // Cor do texto
    backgroundColor: backgroundColor, // Cor de fundo
    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Tamanho do botão
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30), // Bordas arredondadas
    ),
  );
}
