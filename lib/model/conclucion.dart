import 'dart:convert';

Conclucion taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Conclucion.fromMap(jsonData);
}

String taskToJson(Conclucion data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Conclucion {
  int id;
  String nombre;
  String postura;
  String vivienda;

  Conclucion({
    this.id,
    this.nombre,
    this.postura,
    this.vivienda,
  });
  factory Conclucion.fromMap(Map<String, dynamic> json) => new Conclucion(
        id: json["id"],
        nombre: json["nombre"].toString(),
        postura: json["postura"].toString(),
        vivienda: json["vivienda"].toString(),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "postura": postura,
        "vivienda": vivienda,
      };
}
