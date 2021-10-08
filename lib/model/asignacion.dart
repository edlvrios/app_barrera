import 'dart:convert';

Asignacion taskFromJson(String str) {
  final jsonData = json.decode(str);
  return Asignacion.fromMap(jsonData);
}

String taskToJson(Asignacion data) {
  final dyn = data.toMap();
  return jsonEncode(dyn);
}

class Asignacion {
  int credito;
  String nombre;
  String calle;
  String colonia;
  String delegacion;
  String municipio;
  String cp;
  String saldoActual;
  String regimenActual;
  String omisos;
  String mensualidadSegmento;
  String importeRegularizar;
  String seguroActual;
  String seguroOmisos;
  String mesesDisponibles;
  String stm;
  String bcn;
  String dcp;
  String fpp1;
  String fpp2;
  String fpp3;
  String fpp4;
  String fpp5;
  String fpp6;
  String fpp7;
  String fpp8;

  Asignacion(
      {this.credito,
      this.nombre,
      this.calle,
      this.colonia,
      this.delegacion,
      this.municipio,
      this.cp,
      this.saldoActual,
      this.regimenActual,
      this.omisos,
      this.mensualidadSegmento,
      this.importeRegularizar,
      this.seguroActual,
      this.seguroOmisos,
      this.mesesDisponibles,
      this.stm,
      this.bcn,
      this.dcp,
      this.fpp1,
      this.fpp2,
      this.fpp3,
      this.fpp4,
      this.fpp5,
      this.fpp6,
      this.fpp7,
      this.fpp8});
  factory Asignacion.fromMap(Map<String, dynamic> json) => new Asignacion(
      credito: json["credito"],
      nombre: json["nombre"].toString(),
      calle: json["calle"].toString(),
      colonia: json["colonia"].toString(),
      delegacion: json["delegacion"].toString(),
      municipio: json["municipio"].toString(),
      cp: json["cp"].toString(),
      saldoActual: json["saldoActual"].toString(),
      regimenActual: json["regimenActual"].toString(),
      omisos: json["omisos"].toString(),
      mensualidadSegmento: json["mensualidadSegmento"].toString(),
      importeRegularizar: json["importeRegularizar"].toString(),
      seguroActual: json["seguroActual"].toString(),
      seguroOmisos: json["seguroOmisos"].toString(),
      mesesDisponibles: json["mesesDisponibles"].toString(),
      stm: json["stm"].toString(),
      bcn: json["bcn"].toString(),
      dcp: json["dcp"].toString(),
      fpp1: json["fpp1"].toString(),
      fpp2: json["fpp2"].toString(),
      fpp3: json["fpp3"].toString(),
      fpp4: json["fpp4"].toString(),
      fpp5: json["fpp5"].toString(),
      fpp6: json["fpp6"].toString(),
      fpp7: json["fpp7"].toString(),
      fpp8: json["fpp8"].toString());
  Map<String, dynamic> toMap() => {
        "credito": credito,
        "nombre": nombre,
        "calle": calle,
        "colonia": colonia,
        "delegacion": delegacion,
        "municipio": municipio,
        "cp": cp,
        "saldoActual": saldoActual,
        "regimenActual": regimenActual,
        "omisos": omisos,
        "mensualidadSegmento": mensualidadSegmento,
        "importeRegularizar": importeRegularizar,
        "seguroActual": seguroActual,
        "seguroOmisos": seguroOmisos,
        "mesesDisponibles": mesesDisponibles,
        "stm": stm,
        "bcn": bcn,
        "dcp": dcp,
        "fpp1": fpp1,
        "fpp2": fpp2,
        "fpp3": fpp3,
        "fpp4": fpp4,
        "fpp5": fpp5,
        "fpp6": fpp6,
        "fpp7": fpp7
      };
}
