import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/conclucion.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'package:flutter/material.dart';
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

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
    futureConclucion =
        DBProvider.bd.concluciones(prefs.vivienda, prefs.postura);
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
          "Que Conclucion Obtuvo",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: Colors.blueGrey,
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
                Colors.lime[700],
              ),
            );
          },
        ),
      ),
    );
  }
}