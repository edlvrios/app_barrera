import 'dart:io';

import 'package:diseno_login/model/accion.dart';
import 'package:diseno_login/model/asignacion.dart';
import 'package:diseno_login/model/atiende.dart';
import 'package:diseno_login/model/postura.dart';
import 'package:diseno_login/widgets/dropdown/lista_conclucion_widget.dart';
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
    String path = join(documentsDirectory.path, "barrera.db");
    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _createTables);
  }

  void _createTables(Database db, int version) async {
    final existVivienda = db.execute(
        "SELECT name from sqlite_master WHERE type='table' AND name='vivienda';");
    final existAtiende = db.execute(
        "SELECT name from sqlite_master WHERE type='table' AND name='atiende';");
    final existPostura = db.execute(
        "SELECT name from sqlite_master WHERE type='table' AND name='postura';");
    final existConclucion = db.execute(
        "SELECT name from sqlite_master WHERE type='table' AND name='conclucion';");
    final existAccion = db.execute(
        "SELECT name from sqlite_master WHERE type='table' AND name='accion';");
    final existAsignacion = db.execute(
        "SELECT name from sqlite_master WHERE type='table' AND name='asignacion';");
    print(existVivienda);
    print(existAtiende);
    print(existPostura);
    print(existConclucion);
    print(existAccion);
    print(existAsignacion);
    /*
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
        */
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

  existVivienda() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master where type="table" AND name="vivienda" ;');
    return table[0]["existe"];
  }

  newVivienda(Vivienda newVivienda) async {
    final db = await database;
    final tables = await db.rawQuery(
        'SELECT count(*) AS existe FROM sqlite_master where type="table" AND name="vivienda" ;');
    print(tables[0]["existe"]);
    /*var res = await db.rawInsert(
        "INSERT INTO vivienda (id, nombre)"
        " VALUES (?,?)",
        [newVivienda.id, newVivienda.nombre]);
    return res;*/
  }

  Future<List<Vivienda>> viviendas() async {
    // Obtiene una referencia de la base de datos
    final Database db = await database;

    // Consulta la tabla por todos los Dogs.
    final List<Map<String, dynamic>> maps = await db.query('vivienda');

    // Convierte List<Map<String, dynamic> en List<Dog>.
    return List.generate(maps.length, (i) {
      print(maps[i]['nombre']);
      return Vivienda(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
      );
    });
  }

  existAtiende() async {
    final db = await database;
    final table = await db.rawQuery(
        'SELECT count(*) AS existe sqlite_master WHERE type="table" AND name="atiende";');
    return table[0]["existe"];
  }

  newAtiende(Atiende newAtiende) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO atiende (id, nombre,vivienda)"
        " VALUES (?,?,?)",
        [newAtiende.id, newAtiende.nombre, newAtiende.vivienda]);
    return res;
  }

  newPostura(Postura newPostura) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO atiende (id, nombre,atiende,vivienda)"
        " VALUES (?,?,?)",
        [
          newPostura.id,
          newPostura.nombre,
          newPostura.atiende,
          newPostura.vivienda
        ]);
    return res;
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
}
