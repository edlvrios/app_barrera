import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class BusquedaWidget extends StatefulWidget {
  BusquedaWidget({Key key}) : super(key: key);

  @override
  _BusquedaWidgetState createState() => _BusquedaWidgetState();
}

class _BusquedaWidgetState extends State<BusquedaWidget> {
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
      height: size.height * 0.25,
      margin: EdgeInsets.only(right: 0.0, left: 0.0, top: 0.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      decoration: (prefs.colorSecundario)
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(0.0), color: Colors.white)
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
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.support_agent_outlined,
                size: 35.0,
                color: Colors.black,
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
        ],
      ),
    );
  }
}
