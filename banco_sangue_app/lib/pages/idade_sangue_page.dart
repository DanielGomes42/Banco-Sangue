import 'package:flutter/material.dart';
import '../models/IdadeSangue.dart';
import '../services/api_service.dart';

class IdadeSanguePage extends StatelessWidget {
  const IdadeSanguePage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Idade Média por Tipo Sanguíneo')),
      body: FutureBuilder<List<IdadeSangue>>(
        future: api.getIdadePorSangue(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum dado encontrado'));
          }

          final lista = snapshot.data!;
          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              final item = lista[index];
              return ListTile(
                title: Text('Tipo: ${item.tipo}'),
                trailing: Text('Idade Média: ${item.idadeMedia.toStringAsFixed(1)}'),
              );
            },
          );
        },
      ),
    );
  }
}
