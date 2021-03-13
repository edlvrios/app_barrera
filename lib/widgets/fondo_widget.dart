import 'package:flutter/material.dart';

class FondoWidget extends StatelessWidget {
  const FondoWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondo = Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blueGrey[900], Colors.blueGrey[500]])),
    );

    final _circuloCentrado = Container(
      height: 350.0,
      width: 350.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        color: Color.fromRGBO(255, 255, 255, 0.07),
      ),
    );

    final _circuloFondo = Container(
      height: 400.0,
      width: 400.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200.0),
        color: Color.fromRGBO(205, 198, 51, 1.0),
      ),
    );

    return Stack(
      children: [
        fondo,
        Positioned(child: _circuloCentrado, left: -200.0, top: -185.0),
        Positioned(child: _circuloFondo, left: 100.0, top: -300.0),
      ],
    );
  }
}
