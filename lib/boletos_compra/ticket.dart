class Boleto {
  String id_boleto;
  String pelicula;
  String sala;
  String hora;


  Boleto(
      {this.id_boleto,
        this.pelicula,
        this.sala,
        this.hora
      });


  factory Boleto.fromJSON(Map<String, dynamic> json) {
    return Boleto(
      id_boleto: json['id_boleto'],
      pelicula: json['pelicula'],
      sala: json['sala'],
      hora: json['hora']

    );
  }
}