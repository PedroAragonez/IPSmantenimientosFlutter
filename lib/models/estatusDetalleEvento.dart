class estatusDetalleEvento{
  int id;
  String fechaInicio;
  String fechaAsignacion;
  String fechaFinalizacion;
  int estatus;
  String notas;
  double iLatitud;
  double iLongitud;
  double fLatitud;
  double fLongitud;
  int catGanada;
  int catPerdida;
  String fechaPrimerContacto;
  estatusDetalleEvento({
    this.id,
    this.fechaInicio,
    this.fechaAsignacion,
    this.fechaFinalizacion,
    this.estatus,
    this.notas,
    this.iLatitud,
    this.iLongitud,
    this.fLatitud,
    this.fLongitud,
    this.catGanada,
    this.catPerdida,
    this.fechaPrimerContacto
  });
  factory estatusDetalleEvento.fromJson(Map<String, dynamic> json){
    return estatusDetalleEvento(
      id: json['id'] as int,
      fechaInicio: json['fechaInicio'] as String,
      fechaAsignacion: json['fechaAsignacion'] as String,
      fechaFinalizacion: json['fechaFinalizacion'] as String,
      estatus: json['estatus'] as int,
      notas: json['notas'] as String,
      iLatitud: double.parse(json['iLatitud'].toString()),
      iLongitud: double.parse(json['iLongitud'].toString()),
      fLatitud: double.parse(json['fLatitud'].toString()),
      fLongitud: double.parse(json['fLongitud'].toString()),
      catGanada: json['catGanada'] as int,
      catPerdida: json['catPerdida'] as int,
      fechaPrimerContacto: json['fechaPrimerContacto'] as String,
    );
  }

}