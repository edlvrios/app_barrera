import 'package:diseno_login/pages/ajustes_page.dart';
import 'package:diseno_login/pages/busqueda_page.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/pages/login_page.dart';
import 'package:diseno_login/pages/sincronizar_asignacion_page.dart';
import 'package:diseno_login/pages/sincronizar_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MenuWidget extends StatefulWidget {
  MenuWidget({Key key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool _circularProgress = false;
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey[900],
                  ),
                  title: Text(
                    "${prefs.name}",
                    style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                )),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              height: 80.0,
              child: ListTile(
                leading: FittedBox(
                  child: FloatingActionButton(
                    heroTag: 'btnm1',
                    child: Icon(Icons.home),
                    elevation: 0.0,
                    backgroundColor: Colors.blue[200],
                    onPressed: () {},
                  ),
                ),
                title: Text("Inicio",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, HomePage.routName);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 80.0,
              child: ListTile(
                leading: FittedBox(
                  child: FloatingActionButton(
                    heroTag: 'btnm2',
                    child: Icon(Icons.search),
                    elevation: 0.0,
                    backgroundColor: Colors.blueGrey[900],
                    onPressed: () {},
                  ),
                ),
                title: Text("Busqueda",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, BusquedaPage.routName);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 80.0,
              child: ListTile(
                leading: FittedBox(
                  child: FloatingActionButton(
                    heroTag: 'btnm3',
                    child: Icon(Icons.cached),
                    elevation: 0.0,
                    backgroundColor: Colors.yellow[800],
                    onPressed: () {},
                  ),
                ),
                title: Text("Sincronizacion Listas",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, SincornizarPage.routName);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              height: 80.0,
              child: ListTile(
                leading: FittedBox(
                  child: FloatingActionButton(
                    heroTag: 'btnm7',
                    child: Icon(Icons.cached),
                    elevation: 0.0,
                    backgroundColor: Colors.yellow[500],
                    onPressed: () {},
                  ),
                ),
                title: Text("Sincronizacion Asignación",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, SincronizarAsignacionPage.routName);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 0.1),
              height: 80.0,
              child: ListTile(
                leading: FittedBox(
                  child: FloatingActionButton(
                    heroTag: 'btnm4',
                    child: Icon(Icons.build),
                    elevation: 0.0,
                    backgroundColor: Colors.cyan[600],
                    onPressed: () {},
                  ),
                ),
                title: Text("Ajustes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, AjustesPage.routName);
                },
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            (_circularProgress == true)
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black))
                : Container(
                    margin: EdgeInsets.only(top: 0.0),
                    height: 50.0,
                    child: ListTile(
                      leading: FittedBox(
                        child: FloatingActionButton(
                          heroTag: 'btnm5',
                          child: Icon(Icons.logout),
                          elevation: 0.0,
                          backgroundColor: Colors.black,
                          onPressed: () {},
                        ),
                      ),
                      title: Text("Salir",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800)),
                      onTap: () async {
                        _circularProgress = true;
                        String uri =
                            "http://187.162.64.236:9090/dombarreraapi/api/auth/logout";
                        var result = await http.get(uri, headers: {
                          'Accept': 'application/json',
                          'X-Request-With': 'XMLHhttpRequest',
                          'Authorization': 'Bearer ${prefs.token}'
                        });
                        final data = json.decode(result.body);
                        if (data['message'] == 'Successfully logged out') {
                          prefs.token = 'sin Token';
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routName);
                          _circularProgress = false;
                        } else {
                          prefs.token = 'sin Token';
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routName);
                          _circularProgress = false;
                        }
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
