        import 'package:flutter/material.dart';
import '../models/imc_faixa.dart';
import '../services/api_service.dart';

class ImcFaixaPage extends StatelessWidget {
  const ImcFaixaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('IMC médio por faixa etária')),
      body: FutureBuilder<List<ImcFaixa>>(
        future: api.getImcPorFaixa(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado encontrado'));
          }

          final imcs = snapshot.data!;
          return ListView.builder(
            itemCount: imcs.length,
            itemBuilder: (context, index) {
              final item = imcs[index];
              return ListTile(
                title: Text('Faixa: ${item.faixa}'),
                trailing: Text('IMC: ${item.imc.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
