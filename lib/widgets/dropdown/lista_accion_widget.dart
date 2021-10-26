import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/accion.dart';
import 'package:flutter/material.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'dart:async';
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

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
    futureAccion =
        DBProvider.bd.acciones(prefs.vivienda, prefs.postura, prefs.conclucion);
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
                          title: Text(
                            data[index].nombre,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800),
                          ),
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
