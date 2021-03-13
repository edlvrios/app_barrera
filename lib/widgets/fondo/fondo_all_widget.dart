import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class FondoAllWidget extends StatefulWidget {
  FondoAllWidget({Key key}) : super(key: key);

  @override
  _FondoAllWidgetState createState() => _FondoAllWidgetState();
}

class _FondoAllWidgetState extends State<FondoAllWidget> {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    if (prefs.colorSecundario == true) {
      final gradientDark = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.6),
            end: FractionalOffset(0.0, 1.0),
            colors: [
              Color.fromRGBO(40, 62, 81, 1.0),
              Color.fromRGBO(75, 121, 161, 1.0),
            ],
          ),
        ),
      );
      return Scaffold(
        body: Stack(
          children: [gradientDark],
        ),
      );
    } else {
      final gradientLight = Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.0, 0.6),
            end: FractionalOffset(0.0, 1.0),
            colors: [
              Color.fromRGBO(150, 201, 61, 1.0),
              Color.fromRGBO(0, 176, 155, 1.0),
            ],
          ),
        ),
      );
      return Scaffold(
        body: Stack(
          children: [gradientLight],
        ),
      );
    }
  }
}

/*class FondoAllWidget extends StatelessWidget {
  const FondoAllWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Colors.blueGrey,
            Colors.blueGrey,
          ],
        ),
      ),
    );
    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        width: 360.0,
        height: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(colors: [
            Colors.lime,
            Colors.lime,
          ]),
        ),
      ),
    );

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: -100.0,
          child: cajaRosa,
        ),
      ],
    );
  }
}*/
