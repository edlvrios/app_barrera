import 'dart:convert';
import 'dart:typed_data';

import 'package:diseno_login/pages/gestion/gestion_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:diseno_login/widgets/take_picture_page.dart';
import 'package:camera/camera.dart';

class CamaraPage extends StatefulWidget {
  static final String routName = 'foto';
  CamaraPage({Key key}) : super(key: key);

  @override
  _CamaraPageState createState() => _CamaraPageState();
}

class _CamaraPageState extends State<CamaraPage> {
  final prefs = new PreferenciasUsuario();
  // ignore: avoid_init_to_null

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
    prefs.foto = base;
    setState(() {
      prefs.rutaFoto = result;
      prefs.foto = base;
      prefs.vivienda = '';
      prefs.atiende = '';
      prefs.postura = '';
      prefs.conclucion = '';
      prefs.accion = '';
      imageFinal = imageConvert;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GestionPage(),
        ),
      );
    });
  }

  void initState() {
    super.initState();
    _showCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Text('');
  }
}
