import 'dart:convert';

class catSeries{
  int id ;
  String numeroSerie;
  String modelo;
  String marca;
  String ubicacion;
  String cliente;
  catSeries(
      {
        this.id,
        this.numeroSerie,
        this.modelo,
        this.marca,
        this.ubicacion,
        this.cliente
      });

  factory catSeries.fromJson(Map<String, dynamic> json) {
    return catSeries(
      id: json['id'] as int,
      numeroSerie: json['numeroSerie'] as String,
      modelo: json['modelo'] as String,
      marca: json['marca'] as String,
      ubicacion: json['ubicacion'] as String,
      cliente: json['cliente'] as String,
    );
  }
  static Map<String, dynamic> toMap(catSeries book) => {
    'id': book.id,
    'numeroSerie': book.numeroSerie,
    'modelo': book.modelo,
    'marca': book.marca,
    'ubicacion': book.ubicacion,
    'cliente': book.cliente,
  };

  static String encode(List<catSeries> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => catSeries.toMap(music))
        .toList(),
  );

  static List<catSeries> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<catSeries>((item) => catSeries.fromJson(item))
          .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numeroSerie': numeroSerie,
      'modelo': modelo,
      'marca': marca,
      'ubicacion': ubicacion,
      'cliente': cliente,
    };
  }
}