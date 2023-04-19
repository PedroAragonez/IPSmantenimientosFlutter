class catCliente{
  int id;
  String email;
  String nombre;
  String empresa;
  catCliente(
      {
        this.id,
        this.email,
        this.nombre,
        this.empresa,
      });

  factory catCliente.fromJson(Map<String, dynamic> json) {
    return catCliente(
      id: json['id'] as int,
      email: json['email'] as String,
      nombre: json['nombre'] as String,
      empresa: json['empresa'] as String,
    );
  }
}