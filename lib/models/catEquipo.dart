class catEquipo{
  int id;
  String nombre;
  catEquipo(
      {
        this.id,
        this.nombre,
      });

  factory catEquipo.fromJson(Map<String, dynamic> json) {
    return catEquipo(
      id: json['id'] as int,
      nombre: json['nombre'] as String,
    );
  }
}