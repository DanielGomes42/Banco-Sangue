class Candidato {
  final String nome;
  final int idade;
  final String sexo;
  final String estado;
  final String tipoSanguineo;
  final double peso;
  final double altura;

  Candidato({
    required this.nome,
    required this.idade,
    required this.sexo,
    required this.estado,
    required this.tipoSanguineo,
    required this.peso,
    required this.altura,
  });

  factory Candidato.fromJson(Map<String, dynamic> json) {
    return Candidato(
      nome: json['nome'],
      idade: json['idade'],
      sexo: json['sexo'],
      estado: json['estado'],
      tipoSanguineo: json['tipoSanguineo'],
      peso: (json['peso'] as num).toDouble(),
      altura: (json['altura'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idade': idade,
      'sexo': sexo,
      'estado': estado,
      'tipoSanguineo': tipoSanguineo,
      'peso': peso,
      'altura': altura,
    };
  }
}
