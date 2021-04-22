import 'dart:convert';
import 'dart:io';

import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/dropdown/lista_vivienda_widget.dart';
import 'package:diseno_login/widgets/posicion/posicion_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(GestionPage());

class GestionPage extends StatefulWidget {
  static final String routName = 'gestion';
  final String vivienda;
  GestionPage({this.vivienda, Key key}) : super(key: key);

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
            SizedBox(height: 0.5),
            PosicionWidget(),
            SizedBox(height: 0.5),
            _listaVivienda()
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
            leading: Icon(Icons.people, color: Colors.lightBlueAccent[400]),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
            title: Text('Tipo de Vivienda'),
            subtitle: (widget.vivienda == null)
                ? Text('Selecciona el tipo de Vivienda')
                : Text("${widget.vivienda}",
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
                  Icon(Icons.account_circle,
                      color: Colors.indigoAccent, size: 30.0),
                  Text('${prefs.credito}',
                      style: TextStyle(fontSize: 15.0, color: Colors.grey[700]))
                ],
              ),
            ),
          );
  }
}
