import 'dart:convert';
import 'dart:io';

import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/dropdown/lista_atiende_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_postura_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_vivienda_widget.dart';
import 'package:diseno_login/widgets/posicion/posicion_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(GestionPage());

class GestionPage extends StatefulWidget {
  static final String routName = 'gestion';
  final String vivienda;
  final String atiende;
  final String postura;
  GestionPage({this.vivienda, this.atiende, this.postura, Key key})
      : super(key: key);

  @override
  _GestionPageState createState() => _GestionPageState();
}

class _GestionPageState extends State<GestionPage> {
  final prefs = new PreferenciasUsuario();
  // ignore: avoid_init_to_null
  File imageFinal;
  void initState() {
    super.initState();
    _convertbasetofile();
  }

  void _convertbasetofile() {
    print(prefs.rutaFoto);
    final decodeBytes = base64Decode(prefs.foto);
    final file = File(prefs.rutaFoto);
    file.writeAsBytesSync(decodeBytes);
    setState(() {
      imageFinal = file;
    });
  }

  final estiloTitulo = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (prefs.colorSecundario == false)
          ? Colors.blue
          : Color.fromRGBO(52, 73, 94, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _crearImagen(context),
            _crearTitulo(),
            SizedBox(height: 0.0),
            PosicionWidget(),
            SizedBox(height: 0.5),
            _listaVivienda(),
            SizedBox(height: 0.5),
            _listaAtiende(),
            SizedBox(height: 0.5),
            _listaPostura(),
          ],
        ),
      ),
    );
  }

  Widget _crearImagen(BuildContext context) {
    return (prefs.foto == '')
        ? Text('')
        : Container(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'scroll'),
              child: Image(
                image: FileImage(imageFinal),
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  Widget _listaVivienda() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.apartment,
              color: Colors.lime,
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            title: Text('Tipo de Vivienda'),
            subtitle: (prefs.vivienda == '')
                ? Text('Selecciona el tipo de Vivienda')
                : Text("${prefs.vivienda}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaVivienda(),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listaAtiende() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.lime,
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            title: Text('Quien de Atiende'),
            subtitle: (prefs.vivienda == '')
                ? Text('Selecciona Quien Atiende')
                : Text("${prefs.atiende}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaAtiende(vivienda: widget.vivienda),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listaPostura() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.people,
              color: Colors.lime,
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            title: Text('Quien Postura Tiene'),
            subtitle: (prefs.vivienda == '')
                ? Text('Selecciona Que Postura Tiene')
                : Text("${prefs.postura}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaPostura(
                      vivienda: widget.vivienda, atiende: widget.atiende),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _crearTitulo() {
    return (prefs.foto == '')
        ? Text('')
        : SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 30.0, bottom: 30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Gestion', style: estiloTitulo),
                      ],
                    ),
                  ),
                  Icon(Icons.account_circle, color: Colors.lime, size: 45.0),
                  Text('${prefs.credito}',
                      style: TextStyle(fontSize: 15.0, color: Colors.grey[700]))
                ],
              ),
            ),
          );
  }
}
