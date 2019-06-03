class Pelicula {
  String id_pelicula;
  String nombre;
  String duracion;
  String id_clasificacion;
  String id_genero;
  String imagen;

  //int color;

  Pelicula({this.id_pelicula,
    this.nombre,
    this.duracion,
    this.id_clasificacion,
    this.id_genero,
    this.imagen,
    //this.color,
  });


  factory Pelicula.fromJSON(Map<String, dynamic> json) {
    return
      Pelicula(
        id_pelicula: json['id_pelicula'],
        nombre: json['nombre'],
        duracion: json['duracion'],
        id_clasificacion: json['id_clasificacion'],
        id_genero: json['id_genero'],
        imagen: json['imagen'],
        //color: json['color']
    );
  }

}


