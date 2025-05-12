import 'package:flutter/material.dart';
import '../models/cadidato.dart';
import '../services/api_service.dart';

class CadastroCandidatoPage extends StatefulWidget {
  const CadastroCandidatoPage({super.key});

  @override
  State<CadastroCandidatoPage> createState() => _CadastroCandidatoPageState();
}

class _CadastroCandidatoPageState extends State<CadastroCandidatoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();
  final _sexoController = TextEditingController();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _tipoSanguineoController = TextEditingController();
  final _estadoController = TextEditingController();

  void _enviar() async {
    if (_formKey.currentState!.validate()) {
      final candidato = Candidato(
        nome: _nomeController.text,
        idade: int.parse(_idadeController.text),
        sexo: _sexoController.text,
        peso: double.parse(_pesoController.text),
        altura: double.parse(_alturaController.text),
        tipoSanguineo: _tipoSanguineoController.text,
        estado: _estadoController.text,
      );

      try {
        await ApiService().enviarCandidatos([candidato]);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Candidato enviado com sucesso!')),
        );
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Candidato')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome'), validator: (v) => v!.isEmpty ? 'Informe o nome' : null),
              TextFormField(controller: _idadeController, decoration: const InputDecoration(labelText: 'Idade'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Informe a idade' : null),
              TextFormField(controller: _sexoController, decoration: const InputDecoration(labelText: 'Sexo (M/F)'), validator: (v) => v!.isEmpty ? 'Informe o sexo' : null),
              TextFormField(controller: _pesoController, decoration: const InputDecoration(labelText: 'Peso (kg)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Informe o peso' : null),
              TextFormField(controller: _alturaController, decoration: const InputDecoration(labelText: 'Altura (m)'), keyboardType: TextInputType.number, validator: (v) => v!.isEmpty ? 'Informe a altura' : null),
              TextFormField(controller: _tipoSanguineoController, decoration: const InputDecoration(labelText: 'Tipo Sanguíneo'), validator: (v) => v!.isEmpty ? 'Informe o tipo sanguíneo' : null),
              TextFormField(controller: _estadoController, decoration: const InputDecoration(labelText: 'Estado (UF)'), validator: (v) => v!.isEmpty ? 'Informe o estado' : null),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _enviar, child: const Text('Enviar'))
            ],
          ),
        ),
      ),
    );
  }
}
