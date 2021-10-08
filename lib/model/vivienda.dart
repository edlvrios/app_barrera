import 'dart:convert';

Vivienda tasksFromJson(String str) {
  final jsonData = json.decode(str);
  return Vivienda.fromMap(jsonData);
}

String taskToJson(Vivienda data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Vivienda {
  int id;
  String nombre;

  Vivienda({this.id, this.nombre});
  factory Vivienda.fromMap(Map<String, dynamic> json) => new Vivienda(
        id: json["id"],
        nombre: json["nombre"].toString(),
      );

  Map<String, dynamic> toMap() => {"id": id, "nombre": nombre};
}
