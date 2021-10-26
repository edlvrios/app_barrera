import 'dart:async';
import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/asignacion.dart';
import 'package:diseno_login/pages/busqueda_page.dart';
import 'package:diseno_login/pages/foto/foto_page.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_package_manager/flutter_package_manager.dart';
//packetes de terceros
import 'package:http/http.dart' as http;

//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
void main() => runApp(InfoPage());

class InfoPage extends StatefulWidget {
  static final String routeName = 'informacion';
  final String credito;
  final prefs = new PreferenciasUsuario();
  
  InfoPage({this.credito, Key key}) : super(key: key);
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final prefs = new PreferenciasUsuario();
  Future<List<Asignacion>>futureCredito;
  @override
  void initState() {
    getPackageInfo();
    prefs.credito = widget.credito;
    super.initState();
    futureCredito=DBProvider.bd.getCredito(prefs.credito);
    final time = DateTime.now();
    prefs.horaInicio = time.hour.toString() +
        ":" +
        time.minute.toString() +
        ":" +
        time.second.toString();
  }

  // ignore: missing_return
  Future<PackageInfo> getPackageInfo() async {
    List apps = await FlutterPackageManager.getUserInstalledPackages();
    for (var app in apps) {
      if (app == 'com.lexa.fakegps') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.lexa.fakegps';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          prefs.nameFakeApp = '';
        }
      } else if (app == 'com.blogspot.newapphorizons.fakegps') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.blogspot.newapphorizons.fakegps';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          prefs.nameFakeApp = '';
        }
      } else if (app == 'com.rosteam.gpsemulator') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.rosteam.gpsemulator';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          prefs.nameFakeApp = '';
        }
      } else if (app == 'com.incorporateapps.fakegps.fre') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.incorporateapps.fakegps.fre';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          prefs.nameFakeApp = '';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, BusquedaPage.routName),
        ),
        title: Text(
          "Información del Credito",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: (prefs.fakeGps)
          ? AlertDialog(
              title: const Text('Atencion '),
              content: const Text(
                  'Detectamos que estas inflingiendo en las normas de trabajo de Bufete Jurídico Barrera Badillo S.C. al instalar Apps que modifican tu ubicación, se envio un reporte de monitoreo a tu supervisor'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    Navigator.pushReplacementNamed(context, HomePage.routName)
                  },
                  child: const Text('Enterado'),
                ),
              ],
            )
          : Center(
              child: FutureBuilder<List<Asignacion>>(
                future: futureCredito,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Asignacion> data = snapshot.data;
                    if(data.length>0){
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(children: [
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 15.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.tag,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(Icons.check,
                                      color: Colors.blueGrey[900]),
                                  title: Text(
                                    "CREDITO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].credito.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.people,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(Icons.check,
                                      color: Colors.blueGrey[900]),
                                  title: Text(
                                    "ACREDITADO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].nombre.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "CALLE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].calle.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "COLONIA",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].colonia.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "DELEGACION",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].delegacion.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "ESTADO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].municipio.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "CODIGO POSTAL",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].cp.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.attach_money,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(Icons.check,
                                      color: Colors.blueGrey[900]),
                                  title: Text(
                                    "SALDO ACTUAL",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    '${data[index].saldoActual}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "REGIMEN ACTUAL",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].regimenActual.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "OMISOS",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].omisos.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "MENSUALIDAD SEGMENTO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index]
                                        .mensualidadSegmento
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "IMPORTE A REGULARIZAR",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    '${data[index].importeRegularizar}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "SEGURO ACTUAL",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    '${data[index].seguroActual}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.attach_money,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "SEGURO OMISOS",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].seguroOmisos,
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "MESES DISPONIBLES",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].mesesDisponibles.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.insert_invitation,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "STM",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].stm.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "BCN",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].bcn.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "DCP",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].bcn,
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "FFP #1",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp1.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "FFP #2",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp2.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "FFP #3",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp3.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.insert_invitation,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "FFP #4",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp4.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.insert_invitation,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "FFP #5",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp5.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(Icons.insert_invitation,
                                      color: Colors.blueGrey[600]),
                                  trailing: Icon(Icons.check,
                                      color: Colors.blueGrey[900]),
                                  title: Text(
                                    "FFP #6",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp6.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.white),
                                margin: EdgeInsets.only(
                                    top: 5.0, left: 10.0, right: 10.0),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.insert_invitation,
                                    color: Colors.blueGrey[600],
                                  ),
                                  trailing: Icon(
                                    Icons.check,
                                    color: Colors.blueGrey[900],
                                  ),
                                  title: Text(
                                    "FFP #7",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  subtitle: Text(
                                    data[index].fpp7.toString(),
                                    style: TextStyle(
                                        color: Colors.blueGrey[600],
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(top: 10.0, left: 0.0),
                                  width: 250.0,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Gestionar',
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey[900],
                                      onPrimary: Colors.white,
                                      onSurface: Colors.grey,
                                      elevation: 0.0,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, CamaraPage.routName);
                                    },
                                  ))
                            ]),
                          );
                        },
                      );
                    } else {
                      return AlertDialog(
                        title: const Text('Verifica el numero ingresado '),
                        content: const Text('Cuenta no asignada'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => {
                              Navigator.pushReplacementNamed(
                                context,
                                BusquedaPage.routName,
                              )
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text('erro');
                  }
                  return LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation(
                      (prefs.colorSecundario == false)
                          ? Colors.cyan[600]
                          : Color.fromRGBO(52, 73, 94, 1.0),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
