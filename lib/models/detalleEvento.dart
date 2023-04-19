class detalleEvento{
  int id;
  int idEvento;
  String tipoEquipo;
  String modelo;
  String marca;
  String numeroSerie;
  String accesorios;
  String falla;
  detalleEvento(
      {
        this.id,
        this.idEvento,
        this.tipoEquipo,
        this.modelo,
        this.marca,
        this.numeroSerie,
        this.accesorios,
        this.falla
      });

  factory detalleEvento.fromJson(Map<String, dynamic> json) {
    return detalleEvento(
      id: json['id'] as int,
      idEvento: json['idEvento'] as int,
      tipoEquipo: json['tipoEquipo'] as String,
      modelo: json['modelo'] as String,
      marca: json['marca'] as String,
      numeroSerie: json['numeroSerie'] as String,
      accesorios: json['accesorios'] as String,
      falla: json['falla'] as String,
    );
  }
}