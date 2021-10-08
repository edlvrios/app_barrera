import 'dart:convert';

Accion taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Accion.fromMap(jsonData);
}

String taskToJson(Accion data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Accion {
  int id;
  String nombre;
  String conclucion;
  String postura;
  String vivienda;

  Accion({this.id, this.nombre, this.conclucion, this.postura, this.vivienda});
  factory Accion.fromMap(Map<String, dynamic> json) => new Accion(
      id: json["id"],
      nombre: json["nombre"].toString(),
      conclucion: json["conclucion"].toString(),
      postura: json["postura"].toString(),
      vivienda: json["vivienda"].toString());
  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "conclucion": conclucion,
        "postura": postura,
        "vivienda": vivienda,
      };
}
