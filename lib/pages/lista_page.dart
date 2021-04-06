//flutter dart
import 'dart:async';
import 'dart:convert';
import 'package:diseno_login/pages/credito/info_page.dart';
import 'package:flutter/material.dart';
//packetes de terceros
import 'package:http/http.dart' as http;
//views
import 'package:diseno_login/pages/home_page.dart';
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

Future<List<Credito>> fetchCredito() async {
  final prefs = new PreferenciasUsuario();
  final url = 'http://187.162.64.236:9090/api/auth/credito/zona/${prefs.zona}';
  final response = await http.get(url, headers: {
    'Accept': 'application/json',
    'X-Request-With': 'XMLHhttpRequest',
    'Authorization': 'Bearer ${prefs.token}'
  });
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Credito.fromJson(data)).toList();
  }
}

class Credito {
  final int credito;
  final String nombre;
  final String calle;
  final String colonia;
  final String delegacion;
  final String municipio;
  final String cp;
  final String saldoActual;
  final String regimenActual;
  final String omisos;
  final String mensualidadSegmento;
  final String importeRegularizar;
  final String seguroActual;
  final String seguroOmisos;
  final String mesesDisponibles;
  final String stm;
  final String bcn;
  final String dcp;
  final String fpp1;
  final String fpp2;
  final String fpp3;
  final String fpp4;
  final String fpp5;
  final String fpp6;
  final String fpp7;
  final String fpp8;
  final String fpp9;

  Credito({
    this.credito,
    this.nombre,
    this.calle,
    this.colonia,
    this.delegacion,
    this.municipio,
    this.cp,
    this.saldoActual,
    this.regimenActual,
    this.omisos,
    this.mensualidadSegmento,
    this.importeRegularizar,
    this.seguroActual,
    this.seguroOmisos,
    this.mesesDisponibles,
    this.stm,
    this.bcn,
    this.dcp,
    this.fpp1,
    this.fpp2,
    this.fpp3,
    this.fpp4,
    this.fpp5,
    this.fpp6,
    this.fpp7,
    this.fpp8,
    this.fpp9,
  });

  factory Credito.fromJson(Map<String, dynamic> json) {
    return Credito(
      credito: json['credito'],
      nombre: json['nombre'],
    );
  }
}

void main() => runApp(ListaPage());

class ListaPage extends StatefulWidget {
  static final String routName = 'listaCreditos';
  ListaPage({Key key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final prefs = new PreferenciasUsuario();
  Future<List<Credito>> futureCredito;
  @override
  void initState() {
    super.initState();
    futureCredito = fetchCredito();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: (prefs.colorSecundario == false)
              ? Colors.blue
              : Color.fromRGBO(52, 73, 94, 1.0),
          leading: IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, HomePage.routName),
          ),
          title: Text(
            "Creditos En Tu Zona",
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
        body: Center(
          child: FutureBuilder<List<Credito>>(
            future: futureCredito,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Credito> data = snapshot.data;
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
                            leading: Icon(Icons.people,
                                color: Colors.lightBlueAccent[400]),
                            trailing: Icon(Icons.keyboard_arrow_right,
                                color: Colors.blue),
                            subtitle: Text(data[index].credito.toString(),
                                style: TextStyle(
                                    color: Colors.lightBlueAccent[400],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800)),
                            title: Text(data[index].nombre,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w800)),
                            onTap: () {
                              prefs.credito = data[index].credito.toString();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InfoPage(
                                    credito: data[index].credito.toString(),
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
