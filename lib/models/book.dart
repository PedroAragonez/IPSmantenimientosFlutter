import 'dart:convert';

class book{
  String empresa ;
  String cliente;
  String tipo;
  book(
      {
        this.empresa,
        this.cliente,
        this.tipo
      });

  factory book.fromJson(Map<String, dynamic> json) {
    return book(
      empresa: json['empresa'] as String,
      cliente: json['cliente'] as String,
      tipo: json['tipo'] as String,
    );
  }
  static Map<String, dynamic> toMap(book book) => {
    'empresa': book.empresa,
    'cliente': book.cliente,
    'tipo': book.tipo,
  };

  static String encode(List<book> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => book.toMap(music))
        .toList(),
  );

  static List<book> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<book>((item) => book.fromJson(item))
          .toList();

  Map<String, dynamic> toJson() {
    return {
      'empresa': empresa,
      'cliente': cliente,
      'tipo': tipo,
    };
  }
}