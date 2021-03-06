import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'dart:async';
//packetes de terceros
import 'package:http/http.dart' as http;
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

// ignore: missing_return
Future<List<Accion>> fetchAccion() async {
  final prefs = new PreferenciasUsuario();
  final server = 'http://187.162.64.236:9090/dombarreraapi/api/auth/lista/';
  final url = server +
      'conclucion?vivienda=${prefs.vivienda}&postura=${prefs.postura}&conclucion=${prefs.conclucion}';
  final response = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (response.statusCode == 201) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Accion.fromJson(data)).toList();
  }
}

class Accion {
  final int id;
  final String nombre;
  final String conclucion;
  final String postura;
  final String vivienda;
  // ignore: non_constant_identifier_names
  final String data_token;

  Accion({
    this.id,
    this.nombre,
    this.conclucion,
    this.postura,
    this.vivienda,
    // ignore: non_constant_identifier_names
    this.data_token,
  });

  factory Accion.fromJson(Map<String, dynamic> json) {
    return Accion(
        id: json['id'],
        nombre: json['nombre'],
        conclucion: json['conclucion'],
        postura: json['postura'],
        vivienda: json['vivienda'],
        data_token: json['data_token']);
  }
}

class ListaAccion extends StatefulWidget {
  final String vivienda;
  final String postura;
  final String conclucion;
  ListaAccion({this.vivienda, this.postura, this.conclucion, Key key})
      : super(key: key);

  @override
  _ListaAccionState createState() => _ListaAccionState();
}

class _ListaAccionState extends State<ListaAccion> {
  final prefs = new PreferenciasUsuario();
  Future<List<Accion>> futureAccion;
  void initState() {
    super.initState();
    futureAccion = fetchAccion();
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
            onPressed: () => print('')),
        title: Text(
          "Que Accion Tendra",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: FutureBuilder<List<Accion>>(
          future: futureAccion,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Accion> data = snapshot.data;
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
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.blueGrey),
                          title: Text(data[index].nombre,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800)),
                          onTap: () {
                            prefs.accion = data[index].nombre.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GestionPage(
                                  accion: data[index].nombre.toString(),
                                ),
                              ),
                            );
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
