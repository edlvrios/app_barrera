import 'package:diseno_login/db/database.dart';
import 'package:diseno_login/model/atiende.dart';
import 'package:flutter/material.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';

//packetes de terceros
//services
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

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
    futureAtiende = DBProvider.bd.find(prefs.vivienda);
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
      ),
    );
  }
}
