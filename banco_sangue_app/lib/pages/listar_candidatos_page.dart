import 'package:flutter/material.dart';
import '../models/cadidato.dart';
import '../services/api_service.dart';

class ListarCandidatosPage extends StatelessWidget {
  const ListarCandidatosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(title: const Text('Candidatos Cadastrados')),
      body: FutureBuilder<List<Candidato>>(
        future: api.getTodosCandidatos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum candidato cadastrado.'));
          }

          final candidatos = snapshot.data!;


          candidatos.sort((a, b) => b.idade.compareTo(a.idade)); // Ordena por idade decrescente

          return ListView.builder(
            itemCount: candidatos.length,
            itemBuilder: (context, index) {
              final c = candidatos[index];
              return ListTile(
                title: Text('${c.nome} (${c.sexo})'),
                subtitle: Text('Idade: ${c.idade}, Tipo Sanguíneo: ${c.tipoSanguineo}'),
              );
            },
          );
        },
      ),
    );
  }
}
