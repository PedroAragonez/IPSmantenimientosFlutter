class requisitorEvento{
  int id;
  String email;
  String nombre;
  String empresa;
  String fechaIngreso;
  String fechaSalida;
  int estatus;
  String asignado;
  int tipoServicio;
  int prioridad;
  String asunto;
  String PO;
  requisitorEvento(
      {
        this.id,
        this.email,
        this.nombre,
        this.empresa,
        this.fechaIngreso,
        this.fechaSalida,
        this.estatus,
        this.asignado,
        this.tipoServicio,
        this.prioridad,
        this.asunto,
        this.PO
      });

  factory requisitorEvento.fromJson(Map<String, dynamic> json) {
    return requisitorEvento(
      id: json['id'] as int,
      email: json['email'] as String,
      nombre: json['nombre'] as String,
      empresa: json['empresa'] as String,
      fechaIngreso: json['fechaIngreso'] as String,
      fechaSalida: json['fechaSalida'] as String,
      estatus: json['estatus'] as int,
      asignado: json['asignado'] as String,
      tipoServicio: json['tipoServicio'] as int,
      prioridad: json['prioridad'] as int,
      asunto: json['asunto'] as String,
      PO: json['PO'] as String,
    );
  }
}