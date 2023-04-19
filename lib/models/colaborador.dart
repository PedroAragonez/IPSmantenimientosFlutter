class colaborador{
  int id;
  String usuario;
  String nombre;
  String password;
  String oficina;
  int activo;
  int tipo;
  String email;
  String emailSupervisor;
  int administrador;
  int admonDemo;
  colaborador(
      {
        this.id,
        this.usuario,
        this.nombre,
        this.password,
        this.oficina,
        this.activo,
        this.tipo,
        this.email,
        this.emailSupervisor,
        this.administrador,
        this.admonDemo
      });

  factory colaborador.fromJson(Map<String, dynamic> json) {
    return colaborador(
      id: json['id'] as int,
      usuario: json['usuario'] as String,
      nombre: json['nombre'] as String,
      password: json['password'] as String,
      oficina: json['oficina'] as String,
      activo: json['activo'] as int,
      tipo: json['tipo'] as int,
      email: json['email'] as String,
      emailSupervisor: json['emailSupervisor'] as String,
      administrador: json['administrador'] as int,
      admonDemo: json['admonDemo'] as int,
    );
  }
}