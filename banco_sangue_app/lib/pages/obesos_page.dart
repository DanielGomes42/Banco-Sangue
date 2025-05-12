import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ObesosPage extends StatelessWidget {
  const ObesosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Percentual de Obesos por Sexo')),
      body: FutureBuilder<Map<String, double>>(
        future: api.getObesosPorSexo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado encontrado'));
          }

          final dados = snapshot.data!;
          return ListView(
            children: dados.entries.map((e) {
              return ListTile(
                title: Text('Sexo: ${e.key}'),
                trailing: Text('${e.value.toStringAsFixed(2)}%'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
