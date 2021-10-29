import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:diseno_login/model/asignacion.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SincronizarAsignacionPage extends StatefulWidget {
  static final String routName = 'sincronizar_asignacion';
  SincronizarAsignacionPage({Key key}) : super(key: key);

  @override
  _SincronizarAsignacionPageState createState() =>
      _SincronizarAsignacionPageState();
}

class _SincronizarAsignacionPageState extends State<SincronizarAsignacionPage> {
  final prefs = new PreferenciasUsuario();

  var totalAsignacion;
  var totalLocal;
  void initState() {
    super.initState();
    totalAsignacion = getTotalAdignacion();
  }

  getAsignacion() async {
    var dataAsignacion;
    final prefs = new PreferenciasUsuario();
    setState(() {
      prefs.esperaAsignacionLocal = true;
    });
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
        setState(() {
          prefs.cuentasTotalesLocal = i.toString();
        });
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
      setState(() {
        prefs.esperaAsignacionLocal = false;
      });
    }
  }

  getTotalAdignacion() async {
    setState(() {
      prefs.totalAsignacion = true;
    });
    final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/sync/total';
    final data = await http.get(url, headers: {
      'Accept': 'application/json',
      'X-Request-With': 'XMLHhttpRequest',
      'Authorization': 'Bearer ${prefs.token}'
    });
    if (data.body.isNotEmpty) {
      var total = data.body;
      var totalLocal = await DBProvider.bd.conteoAsignacionLocal();
      setState(() {
        prefs.totalAsignacion = false;
        prefs.cuentasTotales = total;
        prefs.cuentasTotalesLocal = totalLocal.toString();
      });
    }
  }

  truncarTabla() async {
    var truncate = await DBProvider.bd.truncarAsignacion();
    setState(() {
      prefs.cuentasTotalesLocal = truncate.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomePage.routName),
        ),
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
            "Sincroniza Asignación",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      drawer: MenuWidget(),
      extendBodyBehindAppBar: true,
      body: Container(
        width: size.width * 0.9,
        child: ListView(
          children: [
            prefs.totalAsignacion == true
                ? Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        strokeWidth: 5.0,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: size.width * 0.95,
                        height: size.height * 0.05,
                        margin:
                            EdgeInsets.only(top: 25.0, left: 15.0, bottom: 0),
                        child: Text(
                          'Numero de cuentas en la nube: ${prefs.cuentasTotales}',
                          style: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        width: size.width * 0.95,
                        height: size.height * 0.05,
                        margin: EdgeInsets.only(
                            top: 25.0, left: 15.0, bottom: 10.0),
                        child: Text(
                          'Cuentas sincronizadas: ${prefs.cuentasTotalesLocal}',
                          style: TextStyle(
                              color: Colors.blueGrey[400],
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        width: size.width * 0.95,
                        margin: EdgeInsets.only(top: 25.0, left: 15.0),
                        child: RoundedProgressBar(
                            percent: 99457,
                            height: 20,
                            borderRadius: BorderRadius.circular(24),
                            style: RoundedProgressBarStyle(
                              widthShadow: 10,
                            ),
                            childCenter:
                                Text("${prefs.cuentasTotalesLocal} cuentas")),
                      ),
                      Container(
                        width: size.width * 0.95,
                        margin: EdgeInsets.only(top: 25.0, left: 15.0),
                        child: ElevatedButton(
                          onPressed: () => {truncarTabla()},
                          child: Text('Borrar Asignación'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red[300],
                            onPrimary: Colors.white,
                            onSurface: Colors.grey,
                            elevation: 3.0,
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.95,
                        margin: EdgeInsets.only(top: 25.0, left: 15.0),
                        child: prefs.esperaAsignacionLocal == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blue),
                                  strokeWidth: 5.0,
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () => {getAsignacion()},
                                child: Text('Sincronizar Asignación'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green[300],
                                  onPrimary: Colors.white,
                                  onSurface: Colors.grey,
                                  elevation: 3.0,
                                ),
                              ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
