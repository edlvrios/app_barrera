import 'dart:convert';

Gestion taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Gestion.fromMap(jsonData);
}

String taskToJson(Gestion data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Gestion {
  int id;
  String usuario;
  String credito;
  String vivienda;
  String atiende;
  String postura;
  String conclucion;
  String accion;
  String latitud;
  String longitud;
  String horaInicio;
  String horaFin;
  String foto;
  String comentario;

  Gestion(
      {this.id,
      this.usuario,
      this.credito,
      this.vivienda,
      this.atiende,
      this.postura,
      this.conclucion,
      this.accion,
      this.latitud,
      this.longitud,
      this.horaInicio,
      this.horaFin,
      this.foto,
      this.comentario});
  factory Gestion.fromMap(Map<String, dynamic> json) => new Gestion(
      id: json["id"],
      usuario: json["usuario"],
      credito: json["credito"],
      vivienda: json["vivienda"],
      atiende: json["atiende"],
      postura: json["postura"],
      conclucion: json["conclucion"],
      accion: json["accion"],
      latitud: json["latitud"],
      longitud: json["longitud"],
      horaInicio: json["horaInicio"],
      horaFin: json["horaFin"],
      foto: json["foto"],
      comentario: json["comentario"]);
  Map<String, dynamic> toMap() => {
        "id": id,
        "usuario": usuario,
        "credito":credito,
        "vivienda":vivienda,
        "atiende":atiende,
        "postura":postura,
        "conclucion":conclucion,
        "accion":accion,
        "latitud":latitud,
        "longitud":longitud,
        "horaInicio":horaInicio,
        "horaFin":horaFin,
        "foto":foto,
        "comentario":comentario
      };
}
