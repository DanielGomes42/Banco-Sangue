class IdadeSangue {
  final String tipo;
  final double idadeMedia;

  IdadeSangue({required this.tipo, required this.idadeMedia});

  factory IdadeSangue.fromJson(Map<String, dynamic> json) {
    return IdadeSangue(
      tipo: json['tipo'],
      idadeMedia: json['idade'],
    );
  }
}
