class DoadorCompatibilidade {
  final String receptor;
  final int quantidade;

  DoadorCompatibilidade({required this.receptor, required this.quantidade});

  factory DoadorCompatibilidade.fromJson(Map<String, dynamic> json) {
    return DoadorCompatibilidade(
      receptor: json['key'],       // se o backend retorna como Map<String, int>
      quantidade: json['value'],   // ajuste se for diferente
    );
  }
}
