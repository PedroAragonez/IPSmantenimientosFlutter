class catMarca{
  int id;
  String marca;
  catMarca(
      {
        this.id,
        this.marca,
      });

  factory catMarca.fromJson(Map<String, dynamic> json) {
    return catMarca(
      id: json['id'] as int,
      marca: json['marca'] as String,
    );
  }
}