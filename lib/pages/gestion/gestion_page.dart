import 'dart:io' as Io;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/posicion/posicion_widget.dart';
import 'package:flutter/material.dart';
import 'package:diseno_login/widgets/take_picture_page.dart';

import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:camera/camera.dart';
import 'package:slimy_card/slimy_card.dart';

class GestionPage extends StatefulWidget {
  static final String routName = 'gestion';
  GestionPage({Key key}) : super(key: key);

  @override
  _GestionPageState createState() => _GestionPageState();
}

class _GestionPageState extends State<GestionPage> {
  final prefs = new PreferenciasUsuario();
  // ignore: avoid_init_to_null
  String _path = null;
  String base64Image = null;
  File imageFinal;
  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    File imagenFile = new File(result);
    Uint8List imagenInBytes = imagenFile.readAsBytesSync();
    String base = base64Encode(imagenInBytes);
    final decodedBytes = base64Decode(base);
    final imageConvert = File(result);
    imageConvert.writeAsBytesSync(decodedBytes);
    setState(() {
      _path = result;
      base64Image = base;
      imageFinal = imageConvert;
    });
  }

  final estiloTitulo = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: (prefs.colorSecundario == false)
          ? Colors.blue
          : Color.fromRGBO(52, 73, 94, 1.0),
      floatingActionButton: Visibility(
        visible: (_path == null) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            _showCamera();
          },
          child: const Icon(Icons.add_a_photo),
          backgroundColor: Colors.indigoAccent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _crearImagen(context),
            _crearTitulo(),
            SizedBox(height: 0.5),
            PosicionWidget(),
          ],
        ),
      ),
    );
  }

  Widget _crearImagen(BuildContext context) {
    return (_path == null)
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

  Widget _crearTitulo() {
    return (_path == null)
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
