import 'package:scoped_model/scoped_model.dart';
import '../model/credito.dart';
import '../scoped_model/credito_model.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  static final String routName = 'listaCreditos';
  ListaPage({Key key}) : super(key: key);

  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
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
        ),
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.blue
            : Color.fromRGBO(52, 73, 94, 1.0),
        body: Container(
          height: 150,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      'Edgar Larios Santiago',
                      style: TextStyle(
                        color: Color(0xff64676F),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Regular',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      '123456789',
                      style: TextStyle(
                        color: Color(0xff464855),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Regular',
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffEEFBFA),
                        ),
                        child: Icon(
                          Icons.thumb_up_off_alt,
                          color: Color(0xff67E4D3),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Text(
                          'Gestionar',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffFFF3F3),
                        ),
                        child: Icon(
                          Icons.do_disturb_alt_rounded,
                          color: Color(0xffFD706B),
                          size: 32,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: Text(
                          'Descartar',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
