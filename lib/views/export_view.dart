import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  Future<void> exportToExcel() async {
    // Lógica para exportar a planilha Excel
    final response =
        await http.get(Uri.parse('http://192.168.0.5:3000/export/excel'));
    if (response.statusCode == 200) {
      // Salvar o arquivo localmente
      // Dependendo da plataforma, você pode precisar de permissões para download
      final file =
          File('/storage/emulated/0/Download/produtos_proximos_estoque.xlsx');
      await file.writeAsBytes(response.bodyBytes);
    } else {
      print('Falha ao exportar');
    }
  }

  Future<void> backupProducts() async {
    // Lógica para backup dos produtos
    final response =
        await http.get(Uri.parse('http://192.168.0.5:3000/backup/products'));
    if (response.statusCode == 200) {
      // Salvar o arquivo localmente
      final file =
          File('/storage/emulated/0/Download/produtos_estoque_backup.json');
      await file.writeAsBytes(response.bodyBytes);
    } else {
      print('Falha ao realizar backup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportação e Backup'),
      ),
      body: Padding(
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
                    groupValue: 'exportOption',
                    onChanged: (value) {},
                    title: const Text('Por estoque'),
                  ),
                  RadioListTile(
                    value: 'validade',
                    groupValue: 'exportOption',
                    onChanged: (value) {},
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
    );
  }
}
