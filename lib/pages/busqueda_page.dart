//flutter
import 'package:diseno_login/pages/credito/info_page.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';
import 'package:flutter/material.dart';
//service
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

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
      _circularProgress = true;
    });
    if (_creditoController.text.isNotEmpty) {
      prefs.credito = _creditoController.text.trim();
      Navigator.pushReplacementNamed(context, InfoPage.routeName);
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
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
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
      body: Stack(
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
          Positioned(child: _cartaBusquedaRapida(context), top: 140, left: 10)
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
                      color: Colors.lightBlueAccent[400],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800),
                ),
              )
            ]),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 80.0),
          child: TextField(
            controller: _creditoController,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              enabledBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(0.0),
                borderSide: BorderSide(color: Colors.grey[300]),
              ),
              focusedBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey[400]),
                  gapPadding: 4.0),
              hintText: 'Credito',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.add_ic_call,
                color: Colors.cyan[300],
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
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.greenAccent,
                      Colors.cyan[300],
                    ],
                  ),
                ),
                child: Text('Buscar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    )),
              ),
              elevation: 3.0,
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
            ),
          );
  }
}
