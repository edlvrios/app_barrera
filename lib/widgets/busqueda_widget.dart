import 'package:diseno_login/pages/busqueda_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class BusquedaWidget extends StatefulWidget {
  BusquedaWidget({Key key}) : super(key: key);

  @override
  _BusquedaWidgetState createState() => _BusquedaWidgetState();
}

class _BusquedaWidgetState extends State<BusquedaWidget> {
  final GlobalKey<ExpansionTileCardState> cardCredito = new GlobalKey();
  final creditoController = TextEditingController();
  // ignore: unused_field
  String _credito;

  @override
  void dispose() {
    creditoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();
    return Container(
      height: size.height * 0.45,
      margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      decoration: (prefs.colorSecundario)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 198, 255, 1.0),
                  Color.fromRGBO(0, 114, 255, 1.0),
                ],
              ),
            )
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
            ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Busqueda de Credito',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: (prefs.colorSecundario)
                              ? Colors.white
                              : Colors.black),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.support_agent_outlined,
                size: 35.0,
                color: (prefs.colorSecundario) ? Colors.white : Colors.black,
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: size.width - 80.0,
                margin: EdgeInsets.only(top: 15.0),
                child: TextField(
                  controller: creditoController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLengthEnforced: true,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    hintText: 'Ingresa el Credito',
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: size.width - 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70.0,
                      height: 70.0,
                      margin: EdgeInsets.only(top: 10.0),
                      child: FittedBox(
                        child: FloatingActionButton(
                          backgroundColor: Colors.blueGrey,
                          elevation: 0.0,
                          child: Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusquedaPage(
                                  credito: creditoController.text,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
