class Usuario {
  String id_usuario;
  String nombre;
  String email;


  //int color;

  Usuario({this.id_usuario,
    this.nombre,
    this.email,

    //this.color,
  });


  factory Usuario.fromJSON(Map<String, dynamic> json) {
    return
      Usuario(
        id_usuario: json['id_usuario'],
        nombre: json['nombre'],
        email: json['email']

      );
  }

}