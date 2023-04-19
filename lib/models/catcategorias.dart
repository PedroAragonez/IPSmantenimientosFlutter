class catCategorias{
  int id;
  int categoria;
  String desCorta;
  String desLarga;
  int estatus;
  catCategorias(
      {
        this.id,
        this.categoria,
        this.desCorta,
        this.desLarga,
        this.estatus,
      });

  factory catCategorias.fromJson(Map<String, dynamic> json) {
    return catCategorias(
      id: json['id'] as int,
      categoria: json['categoria'] as int,
      desCorta: json['desCorta'] as String,
      desLarga: json['desLarga'] as String,
      estatus: json['estatus'] as int,
    );
  }
}