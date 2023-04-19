class catEmpresa{
  int id;
  String nombre;
  catEmpresa(
      {
        this.id,
        this.nombre
      });

  factory catEmpresa.fromJson(Map<String, dynamic> json) {
    return catEmpresa(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
    );
  }
}