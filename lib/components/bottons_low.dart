import 'package:flutter/material.dart';

/// Cria um widget `BottomAppBar` personalizado com ícones e ações configuráveis.
Widget customBottomAppBar({
  required VoidCallback
      onFloatingActionButtonPressed, // Callback para a ação do FloatingActionButton
  required VoidCallback onHomePressed, // Callback para a ação do ícone de home
  required VoidCallback
      onStoragePressed, // Callback para a ação do ícone de estoque
  required VoidCallback
      onUserPressed, // Callback para a ação do ícone de usuário
  required VoidCallback
      onReportPressed, // Callback para a ação do ícone de relatório
}) {
  return BottomAppBar(
    shape:
        const CircularNotchedRectangle(), // Forma do BottomAppBar com recorte para o FloatingActionButton
    notchMargin: 10.0, // Margem ao redor do recorte do FloatingActionButton
    child: Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround, // Distribui os ícones igualmente
      children: [
        IconButton(
          icon: const Icon(Icons.home), // Ícone de home
          onPressed: onHomePressed, // Ação ao clicar no ícone de home
        ),
        IconButton(
          icon: const Icon(Icons.storage), // Ícone de estoque
          onPressed: onStoragePressed, // Ação ao clicar no ícone de estoque
        ),
        const SizedBox(
            width: 40), // Espaço reservado para o FloatingActionButton
        IconButton(
          icon: const Icon(Icons.verified_user), // Ícone de usuário
          onPressed: onUserPressed, // Ação ao clicar no ícone de usuário
        ),
        IconButton(
          icon: const Icon(Icons.assignment), // Ícone de relatório
          onPressed: onReportPressed, // Ação ao clicar no ícone de relatório
        ),
      ],
    ),
  );
}

/// Cria um widget `FloatingActionButton` personalizado com ação configurável.
Widget customFloatingActionButton(VoidCallback onPressed) {
  return FloatingActionButton(
    onPressed: (onPressed), // Ícone do FloatingActionButton
    backgroundColor: Colors.blue.shade200, // Cor de fundo do botão
    shape: const CircleBorder(), // Forma circular garantida
    elevation: 6, // Ação ao clicar no FloatingActionButton
    child: const Icon(Icons.add), // Elevação do botão (sombra)
    // Você pode adicionar outras propriedades se desejar, como o tamanho do botão
  );
}
