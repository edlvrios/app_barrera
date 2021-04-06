import 'dart:io' as Io;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:diseno_login/widgets/take_picture_page.dart';

import 'package:provider/provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, HomePage.routName),
        ),
        title: Text(
          "Gestion de ${prefs.credito}",
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      backgroundColor: (prefs.colorSecundario == false)
          ? Colors.blue
          : Color.fromRGBO(52, 73, 94, 1.0),
      floatingActionButton: Visibility(
        visible: (_path == null) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            //Navigator.pop(context);
            _showCamera();
          },
          child: const Icon(Icons.add_a_photo),
          backgroundColor: Colors.indigoAccent,
        ),
      ),
      body: Container(
          child: (_path == null)
              ? Text('Hola')
              : ListView(
                  children: [
                    SlimyCard(
                      bottomCardWidget: Text('Prueba'),
                      color: Colors.grey[500],
                      width: size.width * 0.9,
                      topCardHeight: 150,
                      bottomCardHeight: 500,
                      borderRadius: 10,
                      topCardWidget: Container(
                        width: size.width,
                        child: Image.file(
                          imageFinal,
                        ),
                      ),
                      slimeEnabled: true,
                    ),
                  ],
                )),
    );
  }
}
