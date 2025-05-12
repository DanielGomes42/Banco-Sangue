import 'package:flutter/material.dart';
import '../models/doador_compatibilidade.dart';
import '../services/api_service.dart';

class DoadoresPage extends StatelessWidget {
  const DoadoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Doadores por receptor')),
      body: FutureBuilder<List<DoadorCompatibilidade>>(
        future: api.getDoadoresCompativeis(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado encontrado'));
          }

          final doadores = snapshot.data!;
          return ListView.builder(
            itemCount: doadores.length,
            itemBuilder: (context, index) {
              final item = doadores[index];
              return ListTile(
                title: Text('Receptor: ${item.receptor}'),
                trailing: Text('Doadores: ${item.quantidade}'),
              );
            },
          );
        },
      ),
    );
  }
}
