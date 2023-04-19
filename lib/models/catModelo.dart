class catModelo{
  int id;
  int id_marca;
  String modelo;
  catModelo(
      {
        this.id,
        this.id_marca,
        this.modelo,
      });

  factory catModelo.fromJson(Map<String, dynamic> json) {
    return catModelo(
      id: json['id'] as int,
      id_marca: json['id_marca'] as int,
      modelo: json['modelo'] as String,
    );
  }
}