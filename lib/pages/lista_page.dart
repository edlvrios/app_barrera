import 'dart:async';
import 'dart:convert';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
                      height: 130,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: Text(
                                  data[index].nombre,
                                  style: TextStyle(
                                    color: Color(0xff64676F),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Regular',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Text(
                                  data[index].credito.toString(),
                                  style: TextStyle(
                                    color: Color(0xff464855),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Regular',
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[300],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffEEFBFA),
                                    ),
                                    child: Icon(
                                      Icons.thumb_up_off_alt,
                                      color: Color(0xff67E4D3),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      'Gestionar',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'Regular',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFFF3F3),
                                    ),
                                    child: Icon(
                                      Icons.do_disturb_alt_rounded,
                                      color: Color(0xffFD706B),
                                      size: 32,
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      'Descartar',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'Regular',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
