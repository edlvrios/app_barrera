import 'dart:convert';

Postura taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Postura.fromMap(jsonData);
}

String tsakToJson(Postura data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Postura {
  int id;
  String nombre;
  String atiende;
  String vivienda;

  Postura({this.id, this.nombre, this.atiende, this.vivienda});
  factory Postura.fromMap(Map<String, dynamic> json) => new Postura(
        id: json["id"],
        nombre: json["nombre"].toString(),
        atiende: json["atiende"].toString(),
        vivienda: json["vivienda"].toString(),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "atiende": atiende,
        "vivienda": vivienda,
      };
}
