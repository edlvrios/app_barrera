import 'dart:io';

import 'package:diseno_login/model/accion.dart';
import 'package:diseno_login/model/asignacion.dart';
import 'package:diseno_login/model/atiende.dart';
import 'package:diseno_login/model/conclucion.dart';
import 'package:diseno_login/model/gestion.dart';
import 'package:diseno_login/model/postura.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:diseno_login/model/vivienda.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider bd = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "barrera9.db");
    return await openDatabase(path,
        version: 10, onOpen: (db) {}, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS vivienda ("
        "id INTEGER NOT NULL,"
        "nombre VARCHAR(35) NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
    await db.execute("CREATE TABLE IF NOT EXISTS atiende ("
        "id INTEGER NOT NULL,"
        "nombre VARCHAR(35) NOT NULL,"
        "vivienda VARCHAR(255) NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
    await db.execute("CREATE TABLE IF NOT EXISTS postura ("
        "id INTEGER NOT NULL,"
        "nombre VARCHAR(35) NOT NULL,"
        "atiende VARCHAR(255) NOT NULL,"
        "vivienda VARCHAR(255) NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
    await db.execute("CREATE TABLE IF NOT EXISTS conclucion ("
        "id INTEGER NOT NULL,"
        "nombre VARCHAR(35) NOT NULL,"
        "postura VARCHAR(255) NOT NULL,"
        "vivienda VARCHAR(255) NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
    await db.execute("CREATE TABLE IF NOT EXISTS accion ("
        "id INTEGER NOT NULL,"
        "nombre VARCHAR(35) NOT NULL,"
        "conclucion VARCHAR(255) NOT NULL,"
        "postura VARCHAR(255) NOT NULL,"
        "vivienda VARCHAR(255) NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
    await db.execute("CREATE TABLE IF NOT EXISTS gestion ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
        "usuario VARCHAR(80) NOT NULL,"
        "credito VARCHAR(10) NOT NULL,"
        "vivienda VARCHAR(70) NOT NULL,"
        "atiende VARCHAR(70) NOT NULL,"
        "postura VARCHAR(70) NOT NULL,"
        "conclucion VARCHAR(70) NOT NULL,"
        "accion VARCHAR(70) NOT NULL,"
        "latitud VARCHAR(70) NOT NULL,"
        "longitud VARCHAR(70) NOT NULL,"
        "hora_inicio VARCHAR(30) NOT NULL,"
        "hora_fin VARCHAR(30) NOT NULL,"
        "foto BLOB NOT NULL,"
        "comentario TEXT NOT NULL,"
        "CONSTRAINT id_unique UNIQUE (id))");
    await db.execute("CREATE TABLE IF NOT EXISTS asignacion("
        "credito INTEGER NOT NULL,"
        "nombre VARCHAR(100),"
        "calle VARCHAR(100),"
        "colonia VARCHAR(100),"
        "delegacion VARCHAR(100),"
        "municipio VARCHAR(100),"
        "cp VARCHAR(10),"
        "saldoActual VARCHAR(50),"
        "regimenActual VARCHAR(50),"
        "omisos VARCHAR(5),"
        "mensualidadSegmento VARCHAR(50),"
        "importeRegularizar VARCHAR(50),"
        "seguroActual VARCHAR(50),"
        "seguroOmisos VARCHAR(50),"
        "mesesDisponibles VARCHAR(50),"
        "stm VARCHAR(50),"
        "bcn VARCHAR(50),"
        "dcp VARCHAR(255),"
        "fpp1 VARCHAR(255),"
        "fpp2 VARCHAR(255),"
        "fpp3 VARCHAR(255),"
        "fpp4 VARCHAR(255),"
        "fpp5 VARCHAR(255),"
        "fpp6 VARCHAR(255),"
        "fpp7 VARCHAR(255),"
        "fpp8 VARCHAR(255),"
        "CONSTRAINT id_unique UNIQUE (credito))");
  }

  newAsignacion(Asignacion newAsignacion) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO asignacion(credito,nombre,calle,colonia,delegacion,"
        "municipio,cp,saldoActual,regimenActual,omisos,mensualidadSegmento,"
        "importeRegularizar,seguroActual,seguroOmisos,mesesDisponibles,stm,"
        "bcn,dcp,fpp1,fpp2,fpp3,fpp4,fpp5,fpp6,fpp7,fpp8)"
        "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          newAsignacion.credito,
          newAsignacion.nombre,
          newAsignacion.calle,
          newAsignacion.colonia,
          newAsignacion.delegacion,
          newAsignacion.municipio,
          newAsignacion.cp,
          newAsignacion.saldoActual,
          newAsignacion.regimenActual,
          newAsignacion.omisos,
          newAsignacion.mensualidadSegmento,
          newAsignacion.importeRegularizar,
          newAsignacion.seguroActual,
          newAsignacion.seguroOmisos,
          newAsignacion.mesesDisponibles,
          newAsignacion.stm,
          newAsignacion.bcn,
          newAsignacion.dcp,
          newAsignacion.fpp1,
          newAsignacion.fpp2,
          newAsignacion.fpp3,
          newAsignacion.fpp4,
          newAsignacion.fpp5,
          newAsignacion.fpp6,
          newAsignacion.fpp7,
          newAsignacion.fpp8
        ]);
    return res;
  }

  conteoAsignacionLocal() async {
    final db = await database;
    var res = await db.rawQuery('SELECT count(*) as total FROM asignacion;');
    return res[0]['total'];
  }

  truncarAsignacion() async {
    final db = await database;
    await db.rawQuery('delete from asignacion');
    var res = await db.rawQuery('SELECT count(*) as total FROM asignacion;');
    return res[0]['total'];
  }

  Future<List<Asignacion>> getCredito(String credito) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .rawQuery('SELECT * FROM asignacion WHERE credito= ?', [credito]);
    return List.generate(maps.length, (i) {
      return Asignacion(
          credito: maps[i]["credito"],
          nombre: maps[i]["nombre"],
          calle: maps[i]["calle"],
          colonia: maps[i]["colonia"],
          delegacion: maps[i]["delegacion"],
          municipio: maps[i]["municipio"],
          cp: maps[i]["cp"],
          saldoActual: maps[i]["saldoActual"],
          regimenActual: maps[i]["regimenActual"],
          omisos: maps[i]["omisos"],
          mensualidadSegmento: maps[i]["mensualidadSegmento"],
          importeRegularizar: maps[i]["importeRegularizar"],
          seguroActual: maps[i]["seguroActual"],
          seguroOmisos: maps[i]["seguroOmisos"],
          mesesDisponibles: maps[i]["mesesDisponibles"],
          stm: maps[i]["stm"],
          bcn: maps[i]["bcn"],
          dcp: maps[i]["dcp"],
          fpp1: maps[i]["fpp1"],
          fpp2: maps[i]["fpp2"],
          fpp3: maps[i]["fpp3"],
          fpp4: maps[i]["fpp4"],
          fpp5: maps[i]["fpp5"],
          fpp6: maps[i]["fpp6"],
          fpp7: maps[i]["fpp7"],
          fpp8: maps[i]["fpp8"]);
    });
  }

  //VIVIENDA
  existVivienda() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master where type="table" AND name="vivienda" ;');
    return table[0]["existe"];
  }

  newVivienda(Vivienda newVivienda) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO vivienda (id, nombre)"
        " VALUES (?,?)",
        [newVivienda.id, newVivienda.nombre]);
    return res;
    //}
  }

  Future<List<Vivienda>> viviendas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('vivienda');
    return List.generate(maps.length, (i) {
      return Vivienda(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
      );
    });
  }

  //ATIENDE
  existAtiende() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master WHERE type="table" AND name="atiende";');
    return table[0]["existe"];
  }

  newAtiende(Atiende newAtiende) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO atiende (id,nombre,vivienda)"
        " VALUES (?,?,?)",
        [newAtiende.id, newAtiende.nombre, newAtiende.vivienda]);
    return res;
  }

  Future<List<Atiende>> find(String vivienda) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query('atiende',
        where: 'vivienda LIKE ? ', whereArgs: ['%$vivienda%']);
    return List.generate(result.length, (i) {
      return Atiende(
        id: result[i]['id'],
        nombre: result[i]['nombre'],
      );
    });
  }

  //POSTURA
  existPostura() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master WHERE type="table" AND name="postura";');
    return table[0]["existe"];
  }

  newPostura(Postura newPostura) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO postura (id, nombre,atiende,vivienda)"
        " VALUES (?,?,?,?)",
        [
          newPostura.id,
          newPostura.nombre,
          newPostura.atiende,
          newPostura.vivienda
        ]);
    return res;
  }

  Future<List<Postura>> findPostura(String vivienda, String atiende) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM postura where vivienda LIKE ? AND atiende LIKE ?',
        ['%$vivienda%', '%$atiende%']);
    return List.generate(result.length, (i) {
      return Postura(
        id: result[i]['id'],
        nombre: result[i]['nombre'],
      );
    });
  }

  //CONCLUCION
  existConclucion() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master WHERE type="table" AND name="conclucion";');
    return table[0]["existe"];
  }

  newConclucion(Conclucion newConclucion) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO conclucion (id, nombre,postura,vivienda)"
        " VALUES (?,?,?,?)",
        [
          newConclucion.id,
          newConclucion.nombre,
          newConclucion.postura,
          newConclucion.vivienda
        ]);
    return res;
  }

  Future<List<Conclucion>> concluciones(String vivienda, String postura) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM conclucion WHERE vivienda LIKE ? AND postura LIKE ?',
        ['%$vivienda%', '%$postura%']);
    return List.generate(maps.length, (i) {
      return Conclucion(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
      );
    });
  }

  //ACCION
  existAccion() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master WHERE type="table" AND name="accion";');
    return table[0]["existe"];
  }

  newAccion(Accion newAccion) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO accion (id, nombre,conclucion,postura,vivienda)"
        " VALUES (?,?,?,?,?)",
        [
          newAccion.id,
          newAccion.nombre,
          newAccion.conclucion,
          newAccion.postura,
          newAccion.vivienda
        ]);
    return res;
  }

  Future<List<Accion>> acciones(
      String vivienda, String postura, String conclucion) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM accion WHERE vivienda LIKE ? AND postura LIKE ? AND conclucion LIKE ?',
        ['%$vivienda%', '%$postura%', '%$conclucion%']);
    return List.generate(maps.length, (i) {
      return Accion(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
      );
    });
  }

  //GESTION
  Future<List<Gestion>> gestiones() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('gestion');
    return List.generate(maps.length, (i) {
      return Gestion(
          id: maps[i]["id"],
          usuario: maps[i]["usuario"],
          credito: maps[i]["credito"],
          vivienda: maps[i]["vivienda"],
          atiende: maps[i]["atiende"],
          postura: maps[i]["postura"],
          conclucion: maps[i]["conclucion"],
          accion: maps[i]["accion"],
          latitud: maps[i]["latitud"],
          longitud: maps[i]["longitud"],
          horaInicio: maps[i]["hora_inicio"],
          horaFin: maps[i]["hora_fin"],
          foto: maps[i]["foto"],
          comentario: maps[i]["comentario"]);
    });
  }

  getGestiones() async {
    final db = await database;
    final table =
        await db.rawQuery('SELECT count(*) AS resgistros FROM gestion;');
    return table[0]["resgistros"];
  }

  newGestion(Gestion newGestion) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO gestion(usuario,credito,vivienda,atiende,postura,conclucion,accion,latitud,longitud,hora_inicio,hora_fin,foto,comentario)"
        "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          newGestion.usuario,
          newGestion.credito,
          newGestion.vivienda,
          newGestion.atiende,
          newGestion.postura,
          newGestion.conclucion,
          newGestion.accion,
          newGestion.latitud,
          newGestion.longitud,
          newGestion.horaInicio,
          newGestion.horaFin,
          newGestion.foto,
          newGestion.comentario
        ]);
    return res;
  }

  deleteGestion(int id) async {
    final db = await database;
    var res = await db.rawDelete("DELETE FROM gestion  WHERE  id=?", [id]);
    return res;
  }
}
