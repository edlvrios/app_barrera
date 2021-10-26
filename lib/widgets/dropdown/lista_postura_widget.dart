import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/postura.dart';
import 'package:flutter/material.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'dart:async';
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

void main() => runApp(ListaPostura());

class ListaPostura extends StatefulWidget {
  final String vivienda;
  final String atiende;
  ListaPostura({this.vivienda, this.atiende, Key key}) : super(key: key);

  @override
  _ListaPosturaState createState() => _ListaPosturaState();
}

class _ListaPosturaState extends State<ListaPostura> {
  final prefs = new PreferenciasUsuario();
  Future<List<Postura>> futurePostura;
  void initState() {
    super.initState();
    futurePostura = DBProvider.bd.findPostura(prefs.vivienda, prefs.atiende);
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
          "Que Postura Tiene",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: FutureBuilder<List<Postura>>(
          future: futurePostura,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Postura> data = snapshot.data;
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
                              color: Colors.blueGrey[600]),
                          title: Text(data[index].nombre,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w800)),
                          onTap: () {
                            prefs.postura = data[index].nombre.toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GestionPage(
                                  postura: data[index].nombre.toString(),
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
