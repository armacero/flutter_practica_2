class Funcion {
  String idpelicula;
  String nompelicula;
  String idfuncion;
  String sala;
  String hora;

  Funcion(
      {this.idpelicula,
        this.nompelicula,
        this.idfuncion,
        this.sala,
        this.hora});


  factory Funcion.fromJSON(Map<String, dynamic> json) {
    return Funcion(
        idpelicula: json['id_pelicula'],
        nompelicula: json['nombre'],
        idfuncion: json['id_funcion'],
        sala: json['sala'],
        hora: json['hora']
    );
  }
}
