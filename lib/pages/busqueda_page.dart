//flutter
import 'dart:io';
import 'package:flutter/material.dart';
//service
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
//widgets
import 'package:diseno_login/widgets/internet_widget.dart';
import 'package:diseno_login/widgets/take_picture_page.dart';
import 'package:diseno_login/widgets/busqueda_widget.dart';
import 'package:diseno_login/widgets/fondo/fondo_all_widget.dart';
import 'package:diseno_login/widgets/menu/menu_widget.dart';
//external
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

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
  String _path = null;
  void _showCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePicturePage(camera: camera)));
    setState(() {
      _path = result;
    });
  }

  void _showOptions(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 80.0,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  _showCamera();
                },
                leading: Icon(Icons.photo_camera),
                title: Text("Tomar Foto Con La Camara"),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();
    prefs.ultimaPagina = BusquedaPage.routName;
    prefs.credito = widget.credito;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Busqueda de Credito',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: (prefs.colorSecundario) ? Colors.white : Colors.black),
        ),
        backgroundColor: (prefs.colorSecundario)
            ? Color.fromRGBO(40, 62, 81, 1.0)
            : Color.fromRGBO(150, 201, 61, 1.0),
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: MenuWidget(),
      body: Stack(children: [
        FondoAllWidget(),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(40.0),
              ),
              Visibility(
                visible: Provider.of<DataConnectionStatus>(context) ==
                    DataConnectionStatus.disconnected,
                child: InternetWidget(),
              ),
              widget.credito == null
                  ? BusquedaWidget()
                  : Container(
                      height: size.height * 0.15,
                      margin: EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              _path == null
                                  ? Icons.add_a_photo
                                  : Icons.remove_red_eye,
                              color: Colors.blueGrey,
                            ),
                            title: _path == null
                                ? Text('Tomar Foto de Validacion')
                                : Text('Ver Foto de Validacion'),
                            trailing:
                                Icon(Icons.fingerprint, color: Colors.grey),
                            onTap: () => _path == null
                                ? _showOptions(context)
                                : showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        Image.file(File(_path))),
                          ),
                        ],
                      ),
                    ),
              _path != null ? Text('Mostrar info del credito') : Text('Info')
            ],
          ),
        ),
      ]),
    );
  }
}
