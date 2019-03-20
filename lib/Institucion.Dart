

class Institucion
{
  String idInstitucion;
  String nomInstitucion;
  String logoInstitucion;
  String nomCortoInstitucion;


  Institucion({
  this.idInstitucion,
  this.nomInstitucion,
  this.logoInstitucion,
  this.nomCortoInstitucion

});

  factory Institucion.fromJSON(Map<String,dynamic> json){
    return Institucion(
      idInstitucion:json['id_institucion'],
      nomInstitucion: json['institucion'],
      logoInstitucion: json['logotipo'],
      nomCortoInstitucion: json['nombre_corto']
    );
  }
}