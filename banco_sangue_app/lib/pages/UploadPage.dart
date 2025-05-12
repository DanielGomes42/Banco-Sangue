import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../models/cadidato.dart';
import '../services/api_service.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<Candidato> candidatos = [];
  String mensagem = '';

  Future<void> pickAndParseFile() async {



  }

  Future<void> enviar() async {
    if (candidatos.isEmpty) {
      setState(() => mensagem = 'Nenhum candidato para enviar.');
      return;
    }

    try {
      await ApiService().enviarCandidatos(candidatos);
      setState(() => mensagem = 'Upload concluído com sucesso!');
    } catch (e) {
      setState(() => mensagem = 'Erro ao enviar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload de Candidatos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: pickAndParseFile,
              child: const Text('Selecionar arquivo JSON'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: enviar,
              child: const Text('Enviar para API'),
            ),
            const SizedBox(height: 16),
            Text(mensagem),
          ],
        ),
      ),
    );
  }
}
