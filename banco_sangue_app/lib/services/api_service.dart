import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/IdadeSangue.dart';
import '../models/cadidato.dart';
import '../models/doador_compatibilidade.dart';
import '../models/imc_faixa.dart';

class ApiService {
  // 🔄 Use 10.0.2.2 para testes em emulador Android, ou localhost para testes em outro computador
  final String baseUrl = 'http://localhost:8082/api'; // ✅ Para entrega e testes fora do emulador

  // 🔁 Troque para isso se for testar no emulador Android:
  // final String baseUrl = 'http://10.0.2.2:8082/api';

  Future<List<ImcFaixa>> getImcPorFaixa() async {
    print('🔍 Iniciando chamada para $baseUrl/imc-faixa');
    final response = await http.get(Uri.parse('$baseUrl/imc-faixa'));

    print('📥 Status da resposta: ${response.statusCode}');
    print('📦 Corpo: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return jsonMap.entries
          .map((e) => ImcFaixa(faixa: e.key, imc: (e.value as num).toDouble()))
          .toList();
    } else {
      throw Exception('Erro ao buscar IMC por faixa etária');
    }
  }

  Future<Map<String, double>> getObesosPorSexo() async {
    final response = await http.get(Uri.parse('$baseUrl/obesos'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return jsonMap.map((key, value) => MapEntry(key, (value as num).toDouble()));
    } else {
      throw Exception('Erro ao carregar dados de obesidade');
    }
  }

  Future<List<IdadeSangue>> getIdadePorSangue() async {
    final response = await http.get(Uri.parse('$baseUrl/idade-sangue'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> dados = jsonDecode(response.body);
      return dados.entries
          .map((e) => IdadeSangue(tipo: e.key, idadeMedia: (e.value as num).toDouble()))
          .toList();
    } else {
      throw Exception('Falha ao carregar dados de idade por tipo sanguíneo');
    }
  }

  Future<List<DoadorCompatibilidade>> getDoadoresCompativeis() async {
    final response = await http.get(Uri.parse('$baseUrl/doadores'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data.entries
          .map((e) => DoadorCompatibilidade(
        receptor: e.key,
        quantidade: e.value,
      ))
          .toList();
    } else {
      throw Exception('Erro ao buscar dados de doadores compatíveis');
    }
  }

  Future<void> enviarCandidatos(List<Candidato> candidatos) async {
    final response = await http.post(
      Uri.parse('$baseUrl/upload'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(candidatos.map((c) => c.toJson()).toList()),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao enviar candidatos');
    }
  }

  Future<List<Candidato>> getTodosCandidatos() async {
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Candidato.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar candidatos');
    }
  }
}
