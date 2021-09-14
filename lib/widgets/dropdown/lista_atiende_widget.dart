import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'dart:async';
//packetes de terceros
import 'package:http/http.dart' as http;
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

// ignore: missing_return
Future<List<Atiende>> fetchAtiende() async {
  final prefs = new PreferenciasUsuario();
  final url =
      'http://187.162.64.236:9090/dombarreraapi/api/auth/lista/atiende?vivienda=${prefs.vivienda}';
  final response = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (response.statusCode == 201) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Atiende.fromJson(data)).toList();
  }
}

class Atiende {
  final int id;
  final String nombre;
  final String vivienda;
  // ignore: non_constant_identifier_names
  final String data_token;

  Atiende({
    this.id,
    this.nombre,
    this.vivienda,
    // ignore: non_constant_identifier_names
    this.data_token,
  });

  factory Atiende.fromJson(Map<String, dynamic> json) {
    return Atiende(
        id: json['id'],
        nombre: json['nombre'],
        vivienda: json['vivienda'],
        data_token: json['data_token']);
  }
}

void main() => runApp(ListaAtiende());

class ListaAtiende extends StatefulWidget {
  final String vivienda;
  ListaAtiende({this.vivienda, Key key}) : super(key: key);

  @override
  _ListaAtiendeState createState() => _ListaAtiendeState();
}

class _ListaAtiendeState extends State<ListaAtiende> {
  final prefs = new PreferenciasUsuario();
  Future<List<Atiende>> futureAtiende;

  void initState() {
    super.initState();
    futureAtiende = fetchAtiende();
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
            "Quien Atiende ",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: FutureBuilder<List<Atiende>>(
            future: futureAtiende,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Atiende> data = snapshot.data;
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
                            leading:
                                Icon(Icons.people, color: Colors.blueGrey[600]),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.blueGrey[600]),
                            title: Text(data[index].nombre,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800)),
                            onTap: () {
                              prefs.atiende = data[index].nombre.toString();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GestionPage(
                                    atiende: data[index].nombre.toString(),
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
        ));
  }
}
