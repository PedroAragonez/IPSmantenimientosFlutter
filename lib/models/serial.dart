import 'dart:convert';

class serial{
  String empresa;
  String cliente;
  String noserial;
  String estatus;
  serial(
      {
        this.empresa,
        this.cliente,
        this.noserial,
        this.estatus
      });

  factory serial.fromJson(Map<String, dynamic> json) {
    return serial(
      empresa: json['empresa'] as String,
      cliente: json['cliente'] as String,
      noserial: json['noserial'] as String,
      estatus: json['estatus'] as String,
    );
  }
  static Map<String, dynamic> toMap(serial book) => {
    'empresa': book.empresa,
    'cliente': book.cliente,
    'noserial': book.noserial,
    'estatus': book.estatus,
  };

  static String encode(List<serial> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => serial.toMap(music))
        .toList(),
  );

  static List<serial> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<serial>((item) => serial.fromJson(item))
          .toList();

  Map<String, dynamic> toJson() {
    return {
      'empresa': empresa,
      'cliente': cliente,
      'noserial': noserial,
      'estatus': estatus,
    };
  }
}