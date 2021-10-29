import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/gestion.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:http/http.dart' as http;

deleteGestiones(int id) async {
  await DBProvider.bd.deleteGestion(id);
}

class CargaPage extends StatefulWidget {
  static final String routName = 'carga';
  CargaPage({Key key}) : super(key: key);

  @override
  _CargaPageState createState() => _CargaPageState();
}

class _CargaPageState extends State<CargaPage> {
  final prefs = new PreferenciasUsuario();
  Future<List<Gestion>> futureGestion;

  @override
  void initState() {
    super.initState();
    futureGestion = DBProvider.bd.gestiones();
  }

  void cargarGestion(
      int id,
      String username,
      String credito,
      String vivienda,
      String atiende,
      String postura,
      String conclucion,
      String accion,
      String latitud,
      String longitud,
      String horaInicio,
      String horaFinal,
      String foto,
      String comentario) async {
    final url =
        'http://187.162.64.236:9090/dombarreraapi/api/auth/guardar/gestion';
    final body = {
      'usuario': username,
      'credito': credito,
      'vivienda': vivienda,
      'atiende': atiende,
      'postura': postura,
      'conclucion': conclucion,
      'accion': accion,
      'latitud': latitud,
      'longitud': longitud,
      'hora_inicio': horaInicio,
      'hora_fin': horaFinal,
      'foto': foto,
      'telefono': '',
      'email': '',
      'comentario': comentario
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
      await deleteGestiones(id);
      Navigator.pushNamed(context, 'carga');
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
              Navigator.pushReplacementNamed(context, HomePage.routName),
        ),
        title: Text(
          "Cargar Creditos",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<List<Gestion>>(
          future: futureGestion,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Gestion> data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.white),
                        margin:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                        child: ListTile(
                          leading:
                              Icon(Icons.people, color: Colors.blueGrey[600]),
                          trailing:
                              Icon(Icons.cloud_upload, color: Colors.blueGrey),
                          title: Text(
                            '${data[index].usuario}-${data[index].credito}-${data[index].horaInicio}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800),
                          ),
                          onTap: () {
                            cargarGestion(
                                data[index].id,
                                data[index].usuario,
                                data[index].credito,
                                data[index].vivienda,
                                data[index].atiende,
                                data[index].postura,
                                data[index].conclucion,
                                data[index].accion,
                                data[index].latitud,
                                data[index].longitud,
                                data[index].horaInicio,
                                data[index].horaFin,
                                data[index].foto,
                                data[index].comentario);
                          },
                        ),
                      )
                    ]),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation(
                Colors.lime[700],
              ),
            );
          },
        ),
      ),
    );
  }
}
