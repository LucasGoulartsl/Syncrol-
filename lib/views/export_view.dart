import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:my_project_flutter/model/environment.dart';
import 'package:my_project_flutter/views/home_view.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String? exportOption = 'estoque'; // Valor inicial para os RadioListTiles

  // Método para exportar planilha Excel
  Future<void> exportToExcel() async {
    try {
      final response =
          await http.get(Uri.parse('${Environment.baseUrl}/export/excel'));
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final file =
            File('${directory?.path}/produtos_proximos_estoque.xlsx');
        await file.writeAsBytes(response.bodyBytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Arquivo Excel salvo em: ${file.path}')),
        );
      } else {
        throw Exception('Falha ao exportar o arquivo Excel.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  // Método para backup dos produtos
  Future<void> backupProducts() async {
    try {
      final response =
          await http.get(Uri.parse('${Environment.baseUrl}/backup/products'));
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final file = File('${directory?.path}/produtos_estoque_backup.json');
        await file.writeAsBytes(response.bodyBytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backup salvo em: ${file.path}')),
        );
      } else {
        throw Exception('Falha ao realizar o backup.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Exportação
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Exportação'),
                      subtitle: Text('Selecione a opção de exportação'),
                    ),
                    RadioListTile(
                      value: 'estoque',
                      groupValue: exportOption,
                      onChanged: (value) {
                        setState(() {
                          exportOption = value as String?;
                        });
                      },
                      title: const Text('Por estoque'),
                    ),
                    RadioListTile(
                      value: 'validade',
                      groupValue: exportOption,
                      onChanged: (value) {
                        setState(() {
                          exportOption = value as String?;
                        });
                      },
                      title: const Text('Por validade'),
                    ),
                    ElevatedButton(
                      onPressed: exportToExcel,
                      child: const Text('Exportar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Backup
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Backup'),
                      subtitle: Text(
                          'Será realizado o backup de todos os produtos registrados'),
                    ),
                    ElevatedButton(
                      onPressed: backupProducts,
                      child: const Text('Backup'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
