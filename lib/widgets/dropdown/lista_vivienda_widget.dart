import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
//packetes de terceros
import 'package:http/http.dart' as http;
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

// ignore: missing_return
Future<List<Vivienda>> fetchVivienda() async {
  final prefs = new PreferenciasUsuario();
  final url = 'http://187.162.64.236:9090/api/auth/lista/vivienda';
  final response = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (response.statusCode == 201) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Vivienda.fromJson(data)).toList();
  }
}

class Vivienda {
  final int id;
  final String nombre;
  // ignore: non_constant_identifier_names
  final String data_token;

  Vivienda({
    this.id,
    this.nombre,
    // ignore: non_constant_identifier_names
    this.data_token,
  });

  factory Vivienda.fromJson(Map<String, dynamic> json) {
    return Vivienda(
      id: json['id'],
      nombre: json['nombre'],
      data_token: json['data_token'],
    );
  }
}

void main() => runApp(ListaVivienda());

class ListaVivienda extends StatefulWidget {
  ListaVivienda({Key key}) : super(key: key);

  @override
  _ListaViviendaState createState() => _ListaViviendaState();
}

class _ListaViviendaState extends State<ListaVivienda> {
  final prefs = new PreferenciasUsuario();
  Future<List<Vivienda>> futureVivienda;
  void initState() {
    super.initState();
    futureVivienda = fetchVivienda();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: (prefs.colorSecundario == false)
              ? Colors.blue
              : Color.fromRGBO(52, 73, 94, 1.0),
          title: Text(
            "Tipo de Vivienda",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
        body: Center(
          child: FutureBuilder<List<Vivienda>>(
            future: futureVivienda,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Vivienda> data = snapshot.data;
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
                                Icon(Icons.people, color: Colors.cyan[600]),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.cyan[600]),
                            title: Text(data[index].nombre,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800)),
                            onTap: () {
                              prefs.vivienda = data[index].nombre.toString();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GestionPage(
                                    vivienda: data[index].nombre.toString(),
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
        ));
  }
}
