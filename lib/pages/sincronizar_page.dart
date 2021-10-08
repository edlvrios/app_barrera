import 'package:diseno_login/model/atiende.dart';
import 'package:diseno_login/model/vivienda.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
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
    var statusTable = await DBProvider.bd.existVivienda();
    if (statusTable == 1) {
      prefs.syncVivienda = true;
    } else {
      for (int i = 0; i < dataVivienda.length; i++) {
        await DBProvider.bd.newVivienda(new Vivienda(
          id: dataVivienda[i]["id"],
          nombre: dataVivienda[i]["nombre"],
        ));
      }
      prefs.syncVivienda = true;
    }
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
    var statusTable = await DBProvider.bd.existAtiende();
    if (statusTable == 1) {
      prefs.syncAtiende = true;
    } else {
      for (var i = 0; i < dataAtiende.length; i++) {
        await DBProvider.bd.newAtiende(new Atiende(
          id: dataAtiende[i]["id"],
          nombre: dataAtiende[i]["nombre"],
          vivienda: dataAtiende[i]["vivienda"],
        ));
      }
      prefs.syncAtiende = true;
    }
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
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    getVivienda();
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
            "Sincronizacion de Datos",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      body: Container(
          width: size.width * 0.9,
          child: Stack(
            children: [
              _sincronizarAsignacion(context),
              Positioned(child: _sincronizarVivienda(context), top: 70),
              Positioned(child: _sincronizarAtiende(context), top: 150),
              Positioned(child: _sincronizarPostura(context), top: 230),
              Positioned(child: _sincronizarAccion(context), top: 310),
              Positioned(child: _sincronizarConclucion(context), top: 390)
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
                onChanged: (bool state) {},
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
                onChanged: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
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
                onChanged: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
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
                onChanged: (bool state) {
                  print('turned ${(state) ? 'yes' : 'no'}');
                },
              ),
            )
          ],
        )
      ],
    );
  }
}
