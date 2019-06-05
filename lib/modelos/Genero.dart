class Genero {
  String idgenero;
  String genero;

  Genero(
      {this.idgenero,
        this.genero});


  factory Genero.fromJSON(Map<String, dynamic> json) {
    return Genero(
        idgenero: json['id_genero'],
        genero: json['genero']
    );
  }
}
