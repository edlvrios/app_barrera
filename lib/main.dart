import 'dart:async';

import 'package:diseno_login/model/user_location.dart';
import 'package:diseno_login/pages/ajustes_page.dart';
import 'package:diseno_login/pages/busqueda_page.dart';
import 'package:diseno_login/pages/carga/carga_page.dart';
import 'package:diseno_login/pages/credito/info_page.dart';
import 'package:diseno_login/pages/foto/foto_page.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/pages/lista_page.dart';
import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'package:diseno_login/pages/sincronizar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:diseno_login/pages/login_page.dart';
import 'package:diseno_login/pages/register_page.dart';

import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
//Seervice
import 'package:diseno_login/service/location_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    );
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>(create: (_) {
          return LocationService().locationStream;
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        home: HomePage(),
        initialRoute: prefs.ultimaPagina,
        theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blueGrey,
        )),
        routes: {
          LoginPage.routName: (BuildContext context) => LoginPage(),
          RegisterPage.routName: (BuildContext context) => RegisterPage(),
          HomePage.routName: (BuildContext context) => HomePage(),
          BusquedaPage.routName: (BuildContext context) => BusquedaPage(),
          AjustesPage.routName: (BuildContext context) => AjustesPage(),
          ListaPage.routName: (BuildContext context) => ListaPage(),
          InfoPage.routeName: (BuildContext context) => InfoPage(),
          CamaraPage.routName: (BuildContext context) => CamaraPage(),
          GestionPage.routName: (BuildContext context) => GestionPage(),
          SincornizarPage.routName: (BuildContext context) => SincornizarPage(),
          CargaPage.routName:(BuildContext context)=>CargaPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 7),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // ignore: missing_return
          builder: (context) {
            if (prefs.ultimaPagina == 'login') {
              LoginPage();
            }
            if (prefs.ultimaPagina == 'register') {
              RegisterPage();
            }
            if (prefs.ultimaPagina == 'home') {
              HomePage();
            }
            if (prefs.ultimaPagina == 'busqueda') {
              BusquedaPage();
            }
            if (prefs.ultimaPagina == 'ajustes') {
              AjustesPage();
            }
            if (prefs.ultimaPagina == 'sincronizar') {
              SincornizarPage();
            }
            if (prefs.ultimaPagina == 'carga') {
              CargaPage();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.indigo,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GeeksForGeeks")),
      body: Center(
          child: Text(
        "Home page",
        textScaleFactor: 2,
      )),
    );
  }
}
