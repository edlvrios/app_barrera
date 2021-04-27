import 'dart:ui';
import 'package:diseno_login/controller/findhelper.dart';
import 'package:diseno_login/pages/ajustes_page.dart';
import 'package:diseno_login/pages/busqueda_page.dart';
import 'package:diseno_login/pages/lista_page.dart';
import 'package:diseno_login/pages/login_page.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

class HomePage extends StatefulWidget {
  static final String routName = 'home';
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  read() async {
    final prefs = new PreferenciasUsuario();
    final value = prefs.token;
    if (value == 'sin Token') {
      Navigator.pushReplacementNamed(context, LoginPage.routName);
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    read();
  }

  @override
  void dispose() {
    super.dispose();
  }

  FindHelper find = new FindHelper();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    prefs.ultimaPagina = HomePage.routName;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: (prefs.colorSecundario == false)
          ? Colors.blue
          : Color.fromRGBO(52, 73, 94, 1.0), // navigation bar color
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
        elevation: 0.0,
        title: Center(
          child: Text(
            "Hola ${prefs.username}",
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      drawer: MenuWidget(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height,
            decoration: BoxDecoration(
                color: (prefs.colorSecundario == false)
                    ? Colors.white
                    : Color.fromRGBO(52, 73, 94, 1.0)),
          ),
          Positioned(
            child: _contenedorAccesoRapido(),
          ),
          Positioned(child: _cartaBusquedaRapida(context), top: 240, left: 10)
        ],
      ),
    );
  }

  Widget _contenedorAccesoRapido() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        color: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn4',
                      child: Icon(Icons.search),
                      elevation: 0.0,
                      backgroundColor: Colors.lightBlue[900],
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, BusquedaPage.routName);
                      },
                    ),
                  ),
                ),
                Text(
                  'Busqueda',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn5',
                      child: Icon(Icons.cached),
                      elevation: 0.0,
                      backgroundColor: Colors.yellow[800],
                      onPressed: () {},
                    ),
                  ),
                ),
                Text(
                  'Sincronizar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 0.0),
            child: Column(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btn6',
                      child: Icon(Icons.build),
                      elevation: 0.0,
                      backgroundColor: Colors.cyan[600],
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, AjustesPage.routName);
                      },
                    ),
                  ),
                ),
                Text(
                  'Ajustes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartaBusquedaRapida(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.3,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.0, left: 25.0),
              child: Text(
                'CREDITOS EN TU ZONA',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.lightBlueAccent[400],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 90.0, left: 120.0),
                  child: Icon(
                    Icons.gps_fixed_outlined,
                    color: Colors.blueGrey,
                    size: 40.0,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 90.0, left: 25.0),
                  child: FutureBuilder(
                    future: find.getCreditoZona(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Text(
                            snapshot.data,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.lightBlueAccent[400],
                                fontSize: 35.0,
                                fontWeight: FontWeight.w800),
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: size.width * 0.8,
              margin: EdgeInsets.only(top: 145.0, left: 30.0),
              child: RaisedButton(
                color: Colors.transparent,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 90.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(0, 114, 255, 1.0),
                        Color.fromRGBO(0, 198, 255, 1.0),
                      ],
                    ),
                  ),
                  child: Text(
                    'Ver Creditos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                elevation: 0.0,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, ListaPage.routName);
                },
              ),
            )
          ],
        )
      ]),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(1, 3), // Shadow position
          ),
        ],
      ),
    );
  }
}
