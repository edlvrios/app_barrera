import 'package:diseno_login/model/accion.dart';
import 'package:diseno_login/model/asignacion.dart';
import 'package:diseno_login/model/atiende.dart';
import 'package:diseno_login/model/conclucion.dart';
import 'package:diseno_login/model/postura.dart';
import 'package:diseno_login/model/vivienda.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:diseno_login/db/database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

getVivienda() async {
  var dataVivienda;

  final prefs = new PreferenciasUsuario();
  final url =
      'http://187.162.64.236:9090/dombarreraapi/api/auth/lista/vivienda';
  final data = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (data.statusCode == 201) {
    dataVivienda = json.decode(data.body);

    for (int i = 0; i < dataVivienda.length; i++) {
      await DBProvider.bd.newVivienda(new Vivienda(
        id: dataVivienda[i]["id"],
        nombre: dataVivienda[i]["nombre"],
      ));
    }
    prefs.syncVivienda = true;
  }
}

getAtiende() async {
  var dataAtiende;
  final prefs = new PreferenciasUsuario();
  final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/sync/atiende';
  final data = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (data.statusCode == 201) {
    dataAtiende = json.decode(data.body);

    for (int i = 0; i < dataAtiende.length; i++) {
      await DBProvider.bd.newAtiende(new Atiende(
          id: dataAtiende[i]["id"],
          nombre: dataAtiende[i]["nombre"],
          vivienda: dataAtiende[i]["vivienda"]));
    }
    prefs.syncAtiende = true;
  }
}

getPostura() async {
  var dataPostura;
  final prefs = new PreferenciasUsuario();
  final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/sync/postura';
  final data = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (data.statusCode == 201) {
    dataPostura = json.decode(data.body);
    for (int i = 0; i < dataPostura.length; i++) {
      await DBProvider.bd.newPostura(new Postura(
          id: dataPostura[i]["id"],
          nombre: dataPostura[i]["nombre"],
          atiende: dataPostura[i]["atiende"].toString(),
          vivienda: dataPostura[i]["vivienda"].toString()));
    }
    prefs.syncPostura = true;
  }
}

getConclucion() async {
  var dataConclucion;
  final prefs = new PreferenciasUsuario();
  final url =
      'http://187.162.64.236:9090/dombarreraapi/api/auth/sync/conclucion';
  final data = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (data.statusCode == 201) {
    dataConclucion = json.decode(data.body);
    for (int i = 0; i < dataConclucion.length; i++) {
      await DBProvider.bd.newConclucion(new Conclucion(
          id: dataConclucion[i]["id"],
          nombre: dataConclucion[i]["nombre"],
          postura: dataConclucion[i]["postura"],
          vivienda: dataConclucion[i]["vivienda"]));
    }
    prefs.syncConclucion = true;
  }
}

getAccion() async {
  var dataAccion;
  final prefs = new PreferenciasUsuario();
  final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/sync/accion';
  final data = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (data.statusCode == 201) {
    dataAccion = json.decode(data.body);
    for (int i = 0; i < dataAccion.length; i++) {
      await DBProvider.bd.newAccion(new Accion(
          id: dataAccion[i]["id"],
          nombre: dataAccion[i]["nombre"],
          conclucion: dataAccion[i]["conclucion"],
          postura: dataAccion[i]["postura"],
          vivienda: dataAccion[i]["vivienda"]));
    }
    prefs.syncAccion = true;
  }
}

getAsignacion() async {
  var dataAsignacion;
  final prefs = new PreferenciasUsuario();
  final url =
      'http://187.162.64.236:9090/dombarreraapi/api/auth/sync/asignacion';
  final data = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (data.statusCode == 200) {
    dataAsignacion = json.decode(data.body);
    for (int i = 0; i < dataAsignacion.length; i++) {
      print(i);
      await DBProvider.bd.newAsignacion(new Asignacion(
          credito: dataAsignacion[i]["credito"],
          nombre: dataAsignacion[i]["nombre"],
          calle: dataAsignacion[i]["calle"],
          colonia: dataAsignacion[i]["colonia"],
          delegacion: dataAsignacion[i]["delegacion"],
          municipio: dataAsignacion[i]["municipio"],
          cp: dataAsignacion[i]["cp"],
          saldoActual: dataAsignacion[i]["saldoActual"],
          regimenActual: dataAsignacion[i]["regimenActual"],
          omisos: dataAsignacion[i]["omisos"],
          mensualidadSegmento: dataAsignacion[i]["mensualidadSegmento"],
          importeRegularizar: dataAsignacion[i]["importeRegularizar"],
          seguroActual: dataAsignacion[i]["seguroActual"],
          seguroOmisos: dataAsignacion[i]["seguroOmisos"],
          stm: dataAsignacion[i]["stm"],
          bcn: dataAsignacion[i]["bcn"],
          dcp: dataAsignacion[i]["dcp"],
          fpp1: dataAsignacion[i]["fpp1"],
          fpp2: dataAsignacion[i]["fpp2"],
          fpp3: dataAsignacion[i]["fpp3"],
          fpp4: dataAsignacion[i]["fpp4"],
          fpp5: dataAsignacion[i]["fpp5"],
          fpp6: dataAsignacion[i]["fpp6"],
          fpp7: dataAsignacion[i]["fpp7"],
          fpp8: dataAsignacion[i]["fpp8"]));
    }
    prefs.syncAsignacion = true;
  }
}

class SincornizarPage extends StatefulWidget {
  static final String routName = 'sincronizar';
  SincornizarPage({Key key}) : super(key: key);

  @override
  _SincornizarPageState createState() => _SincornizarPageState();
}

class _SincornizarPageState extends State<SincornizarPage> {
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    getVivienda();
    getAtiende();
    getPostura();
    getConclucion();
    getAccion();
    //getAsignacion();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    prefs.ultimaPagina = SincornizarPage.routName;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
        elevation: 0.0,
        title: Center(
          child: Text(
            "Sincronizacion de Listas",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      drawer: MenuWidget(),
      extendBodyBehindAppBar: true,
      body: Container(
          width: size.width * 0.9,
          child: Stack(
            children: [
              Positioned(child: _sincronizarAsignacion(context), top: 70),
              Positioned(child: _sincronizarVivienda(context), top: 150),
              Positioned(child: _sincronizarAtiende(context), top: 230),
              Positioned(child: _sincronizarPostura(context), top: 310),
              Positioned(child: _sincronizarAccion(context), top: 390),
              Positioned(child: _sincronizarConclucion(context), top: 470)
            ],
          )),
    );
  }

  Widget _sincronizarAsignacion(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Center(
                child: Text(
                  "Asignacion",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 60),
              child: LiteRollingSwitch(
                value: prefs.syncAsignacion,
                textOn: 'Si',
                textOff: 'No',
                colorOn: Colors.green[300],
                colorOff: Colors.red[300],
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: Duration(milliseconds: 300),
                onChanged: (bool state) {},
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _sincronizarVivienda(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 50,
              ),
              child: Center(
                child: Text(
                  "Vivienda",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 60,
              ),
              child: LiteRollingSwitch(
                value: prefs.syncVivienda,
                textOn: 'Si',
                textOff: 'No',
                colorOn: Colors.green[300],
                colorOff: Colors.red[300],
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: Duration(
                  milliseconds: 300,
                ),
                onChanged: (bool state) {
                  getVivienda();
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _sincronizarAtiende(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 55),
              child: Center(
                child: Text(
                  "Atiende",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 60),
              child: LiteRollingSwitch(
                value: prefs.syncAtiende,
                textOn: 'Si',
                textOff: 'No',
                colorOn: Colors.green[300],
                colorOff: Colors.red[300],
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: Duration(milliseconds: 300),
                onChanged: (bool state) {},
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _sincronizarPostura(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 55),
              child: Center(
                child: Text(
                  "Postura",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 60),
              child: LiteRollingSwitch(
                value: prefs.syncPostura,
                textOn: 'Si',
                textOff: 'No',
                colorOn: Colors.green[300],
                colorOff: Colors.red[300],
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: Duration(milliseconds: 300),
                onChanged: (bool state) {},
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _sincronizarAccion(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 55),
              child: Center(
                child: Text(
                  "Accion",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 60),
              child: LiteRollingSwitch(
                value: prefs.syncAccion,
                textOn: 'Si',
                textOff: 'No',
                colorOn: Colors.green[300],
                colorOff: Colors.red[300],
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: Duration(milliseconds: 300),
                onChanged: (bool state) {},
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _sincronizarConclucion(BuildContext context) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Center(
                child: Text(
                  "Conclucion",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 60),
              child: LiteRollingSwitch(
                value: prefs.syncConclucion,
                textOn: 'Si',
                textOff: 'No',
                colorOn: Colors.green[300],
                colorOff: Colors.red[300],
                iconOn: Icons.check,
                iconOff: Icons.cancel,
                animationDuration: Duration(milliseconds: 300),
                onChanged: (bool state) {},
              ),
            )
          ],
        )
      ],
    );
  }
}
