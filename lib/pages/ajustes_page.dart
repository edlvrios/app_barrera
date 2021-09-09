import 'package:flutter/material.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';

class AjustesPage extends StatefulWidget {
  static final String routName = 'ajustes';
  AjustesPage({Key key}) : super(key: key);

  @override
  _AjustesPageState createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey,
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
            "Ajustes de ${prefs.username}",
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
            decoration: BoxDecoration(color: Colors.white),
            child: Text('Ajustes de ${prefs.username}'),
          ),
          Positioned(
            child: _contenedorAccesoRapido(),
          ),
          Positioned(child: _cartaCreditoBuscado(context), top: 150, left: 10),
          Positioned(child: _cartaUltimPagina(context), top: 300, left: 10),
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
        children: [],
      ),
    );
  }

  Widget _cartaCreditoBuscado(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.17,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.0, left: 35.0),
              child: Text(
                'ULTIMO CREDITO BUSCADO',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 22.0,
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
                  margin: EdgeInsets.only(top: 60.0, left: 15.0),
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btna1',
                      child: Icon(Icons.search),
                      elevation: 0.0,
                      backgroundColor: Colors.blueGrey[900],
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 70.0, left: 10.0),
                    child: Center(
                      child: Text(
                        '${prefs.credito}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800),
                      ),
                    )),
              ],
            )
          ],
        ),
      ]),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  Widget _cartaUltimPagina(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.17,
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 25.0,
                left: 35.0,
              ),
              child: Text(
                'ULTIMA PAGINA VISITADA',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.blueGrey[400],
                    fontSize: 22.0,
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
                  margin: EdgeInsets.only(
                    top: 60.0,
                    left: 40.0,
                  ),
                  child: FittedBox(
                    child: FloatingActionButton(
                      heroTag: 'btna3',
                      child: Icon(Icons.security_outlined),
                      elevation: 0.0,
                      backgroundColor: Colors.yellow[800],
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 70.0, left: 10.0),
                    child: Center(
                      child: Text(
                        '${prefs.ultimaPagina}',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800),
                      ),
                    )),
              ],
            )
          ],
        ),
      ]),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9.0),
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
