import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/vivienda.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';


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
    //getRoute();
    futureVivienda = DBProvider.bd.viviendas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Tipo de Vivienda",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: Colors.blueGrey,
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
                Colors.lime[700],
              ),
            );
          },
        ),
      ),
    );
  }
}
