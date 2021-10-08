import 'dart:convert';

Atiende tasksFromJson(String str) {
  final jsonData = json.decode(str);
  return Atiende.fromMap(jsonData);
}

String taskToJson(Atiende data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Atiende {
  int id;
  String nombre;
  String vivienda;

  Atiende({this.id, this.nombre, this.vivienda});
  factory Atiende.fromMap(Map<String, dynamic> json) => new Atiende(
        id: json["id"],
        nombre: json["nombre"].toString(),
        vivienda: json['vivienda'].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "vivienda": vivienda,
      };
}
