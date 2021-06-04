import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'dart:async';
//packetes de terceros
import 'package:http/http.dart' as http;
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

// ignore: missing_return
Future<List<Conclucion>> fetchConclucion() async {
  final prefs = new PreferenciasUsuario();
  final url =
      'http://187.162.64.236:9090/dombarreraapi/api/auth/lista/conclucion?vivienda=${prefs.vivienda}&postura=${prefs.postura}';
  final response = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (response.statusCode == 201) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Conclucion.fromJson(data)).toList();
  }
}

class Conclucion {
  final int id;
  final String nombre;
  final String postura;
  final String vivienda;
  // ignore: non_constant_identifier_names
  final String data_token;

  Conclucion({
    this.id,
    this.nombre,
    this.postura,
    this.vivienda,
    // ignore: non_constant_identifier_names
    this.data_token,
  });

  factory Conclucion.fromJson(Map<String, dynamic> json) {
    return Conclucion(
        id: json['id'],
        nombre: json['nombre'],
        postura: json['postura'],
        vivienda: json['vivienda'],
        data_token: json['data_token']);
  }
}

class ListaConclucion extends StatefulWidget {
  final String vivienda;
  final String postura;
  ListaConclucion({this.vivienda, this.postura, Key key}) : super(key: key);

  @override
  _ListaConclucionState createState() => _ListaConclucionState();
}

class _ListaConclucionState extends State<ListaConclucion> {
  final prefs = new PreferenciasUsuario();
  Future<List<Conclucion>> futureConclucion;
  void initState() {
    super.initState();
    futureConclucion = fetchConclucion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
        leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => print('')),
        title: Text(
          "Que Conclucion Obtuvo",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: (prefs.colorSecundario == false)
          ? Colors.blue
          : Color.fromRGBO(52, 73, 94, 1.0),
      body: Center(
        child: FutureBuilder<List<Conclucion>>(
          future: futureConclucion,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Conclucion> data = snapshot.data;
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
                          leading: Icon(Icons.people, color: Colors.cyan[600]),
                          trailing: Icon(Icons.keyboard_arrow_right,
                              color: Colors.cyan[600]),
                          title: Text(data[index].nombre,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800)),
                          onTap: () {
                            prefs.conclucion = data[index].nombre.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GestionPage(
                                  conclucion: data[index].nombre.toString(),
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
                (prefs.colorSecundario == false)
                    ? Colors.blue
                    : Color.fromRGBO(52, 73, 94, 1.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
