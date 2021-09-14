//flutter
import 'package:diseno_login/pages/credito/info_page.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';
import 'package:flutter/material.dart';
//service
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_package_manager/flutter_package_manager.dart';

class BusquedaPage extends StatefulWidget {
  static final String routName = 'busqueda';
  final String credito;
  BusquedaPage({this.credito, Key key}) : super(key: key);
  @override
  _BusquedaPageState createState() => _BusquedaPageState();
}

class _BusquedaPageState extends State<BusquedaPage> {
  //url image takepicture
  // ignore: avoid_init_to_null
  final prefs = new PreferenciasUsuario();
  //String _path = null;
  bool _circularProgress = false;
  final TextEditingController _creditoController = new TextEditingController();

  // ignore: unused_element
  void _searchCredito() async {
    setState(() {
      prefs.responseCode = 0;
      _circularProgress = true;
    });
    if (_creditoController.text.isNotEmpty) {
      prefs.credito = _creditoController.text.trim();
      Navigator.pushReplacementNamed(context, InfoPage.routeName);
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    getPackageInfo();
  }

  // ignore: missing_return
  Future<PackageInfo> getPackageInfo() async {
    List apps = await FlutterPackageManager.getUserInstalledPackages();
    for (var app in apps) {
      print(app);
      //com.blogspot.newapphorizons.fakegps
      //com.rosteam.gpsemulator
      //com.incorporateapps.fakegps.fre
      if (app == 'com.lexa.fakegps') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.lexa.fakegps';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          print(response.statusCode);
          prefs.nameFakeApp = '';
        }
      } else if (app == 'com.blogspot.newapphorizons.fakegps') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.blogspot.newapphorizons.fakegps';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          print(response.statusCode);
          prefs.nameFakeApp = '';
        }
      } else if (app == 'com.rosteam.gpsemulator') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.rosteam.gpsemulator';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          print(response.statusCode);
          prefs.nameFakeApp = '';
        }
      } else if (app == 'com.incorporateapps.fakegps.fre') {
        setState(() {
          prefs.fakeGps = true;
          prefs.nameFakeApp = 'com.incorporateapps.fakegps.fre';
        });
        final url = 'http://187.162.64.236:9090/dombarreraapi/api/auth/reporte';
        final body = {
          'usuario': '${prefs.username}',
          'app_name': '${prefs.nameFakeApp}',
        };
        final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'X-Request-With': 'XMLHhttpRequest',
            'Authorization': 'Bearer ${prefs.token}'
          },
          body: body,
        );
        if (response.statusCode == 201) {
          prefs.nameFakeApp = '';
        }
      } else {
        prefs.fakeGps = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    prefs.ultimaPagina = BusquedaPage.routName;
    prefs.credito = widget.credito;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
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
      ),
      drawer: MenuWidget(),
      extendBodyBehindAppBar: true,
      body: (prefs.fakeGps)
          ? AlertDialog(
              title: const Text('Atencion '),
              content: const Text(
                  'Detectamos que estas inflingiendo en las normas de trabajo de Bufete Jurídico Barrera Badillo S.C. al instalar Apps que modifican tu ubicación, se envio un reporte de monitoreo a tu supervisor'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    Navigator.pushReplacementNamed(context, HomePage.routName)
                  },
                  child: const Text('Enterado'),
                ),
              ],
            )
          : Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height,
                  decoration: BoxDecoration(
                    color: (prefs.colorSecundario == false)
                        ? Colors.white
                        : Color.fromRGBO(52, 73, 94, 1.0),
                  ),
                ),
                Positioned(
                  child: _contenedorAccesoRapido(),
                ),
                Positioned(
                    child: _cartaBusquedaRapida(context), top: 140, left: 10)
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
        color: Colors.blueGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 0.0),
            child: Column(
              children: [],
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 0.0),
            child: Column(
              children: [],
            ),
          ),
          Container(
            width: 100.0,
            height: 100.0,
            margin: EdgeInsets.only(top: 0.0),
            child: Column(),
          ),
        ],
      ),
    );
  }

  Widget _cartaBusquedaRapida(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.29,
      child: Stack(children: [
        Row(
          children: [
            Column(children: [
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 15.0),
                child: Text(
                  'Busqueda de Credito',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.blueGrey[500],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800),
                ),
              )
            ]),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 80.0),
          child: TextFormField(
            controller: _creditoController,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(0.0),
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              focusedBorder: new OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]),
                  gapPadding: 4.0),
              hintText: 'Credito',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.add_ic_call,
                color: Colors.blueGrey[300],
              ),
            ),
          ),
        ),
        _crearBoton(context)
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

  Widget _crearBoton(BuildContext context) {
    return _circularProgress == true
        ? CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.blueGrey,
          )
        : Container(
            padding: EdgeInsets.only(top: 150.0, left: 100.0),
            width: 250.0,
            child: ElevatedButton(
              child: Text('Buscar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                onPrimary: Colors.white,
                onSurface: Colors.grey,
                elevation: 0.0,
              ),
              onPressed: () {
                if (_creditoController.text.isNotEmpty) {
                  setState(() {
                    prefs.creditoRespaldo = _creditoController.text.trim();
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InfoPage(
                        credito: _creditoController.text.trim(),
                      ),
                    ),
                  );
                }
              },
            ));
  }
}
