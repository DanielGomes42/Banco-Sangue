import 'package:banco_sangue_app/pages/UploadPage.dart';
import 'package:banco_sangue_app/pages/cadastro_candidato_page.dart';
import 'package:banco_sangue_app/pages/doadores_page.dart';
import 'package:banco_sangue_app/pages/idade_sangue_page.dart';
import 'package:banco_sangue_app/pages/listar_candidatos_page.dart';
import 'package:flutter/material.dart';
import 'pages/imc_faixa_page.dart';
import 'pages/obesos_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco de Sangue',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ImcFaixaPage()),
                );
              },
              child: const Text('Ver IMC por faixa etária'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ObesosPage()),
                );
              },
              child: const Text('Obesos por sexo'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const IdadeSanguePage()),
                );
              },
              child: const Text('Idade por tipo sanguíneo'),
            ),
            ElevatedButton(
              child: const Text('Doadores compatíveis'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DoadoresPage()),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CadastroCandidatoPage()),
                );
              },
              child: const Text('Cadastrar Candidato'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UploadPage()),
                );
              },
              child: const Text('Upload de candidatos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ListarCandidatosPage()),
                );
              },
              child: const Text('Listar Candidatos'),
            ),

          ],
        ),
      ),
    );
  }
}
