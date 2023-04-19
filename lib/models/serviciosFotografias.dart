import 'dart:convert';

class serviciosFotografias{
  int id;
  String idevento ;
  String nombre;
  String contenido;
  serviciosFotografias(
      {
        this.id,
        this.idevento,
        this.nombre,
        this.contenido
      });

  factory serviciosFotografias.fromJson(Map<String, dynamic> json) {
    return serviciosFotografias(
      id: json['id'] as int,
      idevento: json['idevento'] as String,
      nombre: json['nombre'] as String,
      contenido: json['contenido'] as String,
    );
  }
  static Map<String, dynamic> toMap(serviciosFotografias book) => {
    'id': book.id,
    'idevento': book.idevento,
    'nombre': book.nombre,
    'contenido': book.contenido,
  };

  static String encode(List<serviciosFotografias> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => serviciosFotografias.toMap(music))
        .toList(),
  );

  static List<serviciosFotografias> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<serviciosFotografias>((item) => serviciosFotografias.fromJson(item))
          .toList();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idevento': idevento,
      'nombre': nombre,
      'contenido': contenido,
    };
  }
}