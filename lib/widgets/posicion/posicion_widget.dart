import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/model/user_location.dart';

class PosicionWidget extends StatefulWidget {
  PosicionWidget({Key key}) : super(key: key);

  @override
  _PosicionWidgetState createState() => _PosicionWidgetState();
}

class _PosicionWidgetState extends State<PosicionWidget> {
  double latitude;
  double longitude;
  final prefs = new PreferenciasUsuario();

  @override
  void initState() {
    super.initState();
    latitude = prefs.latitude;
    longitude = prefs.longitude;
  }

  final estiloTitulo = TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    final userLocation = Provider.of<UserLocation>(context);
    if (userLocation == null) {
    } else {
      prefs.latitude = userLocation.latitude;
      prefs.longitude = userLocation.longitude;
    }

    return Container(
      child: userLocation == null
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 5.0,
            )
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
                          Text('Tu Pocision', style: estiloTitulo),
                        ],
                      ),
                    ),
                    Icon(Icons.room, color: Colors.indigoAccent, size: 30.0),
                    Text('${prefs.latitude},${prefs.longitude}',
                        style:
                            TextStyle(fontSize: 15.0, color: Colors.grey[700]))
                  ],
                ),
              ),
            ),
    );
  }
}
