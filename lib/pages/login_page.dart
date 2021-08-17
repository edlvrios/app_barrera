import 'dart:ui';

import 'package:diseno_login/controller/authhelper.dart';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/pages/register_page.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static final String routName = 'login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _circularProgress = false;
  read() async {
    final prefs = new PreferenciasUsuario();
    final value = prefs.token;
    if (value != 'sin Token') {
      Navigator.pushReplacementNamed(context, HomePage.routName);
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    read();
  }

  AuthHelper authHelper = new AuthHelper();
  final prefs = new PreferenciasUsuario();
  String msgStaus = '';

  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  _onPressed() {
    setState(() {
      if (_usernameController.text.trim().toLowerCase().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty) {
        _circularProgress = true;
        authHelper
            .loginData(_usernameController.text.trim(),
                _passwordController.text.trim())
            .whenComplete(() {
          if (authHelper.status==true) {
            _circularProgress = false;
            Navigator.pushReplacementNamed(context, LoginPage.routName);
          } else {
            _circularProgress = false;
            Navigator.pushReplacementNamed(context, HomePage.routName);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = LoginPage.routName;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: (prefs.colorSecundario == false)
              ? Colors.white
              : Color.fromRGBO(52, 73, 94, 1.0),
        ),
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.white
            : Color.fromRGBO(52, 73, 94, 1.0),
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [_loginForm(context)],
        ));
  }

  Widget _loginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 0.0,
                ),
                Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/Color-01.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                _texto(context),
                SizedBox(
                  height: 10.0,
                ),
                _subtitulo(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearEmail(context),
                SizedBox(
                  height: 50.0,
                ),
                _crearPassword(context),
                SizedBox(
                  height: 40.0,
                ),
                _crearBoton(context),
                Divider(
                  height: 50,
                  endIndent: 1.5,
                  thickness: 0.1,
                ),
                Text(
                  '¿Aún no tienes una cuenta?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: (prefs.colorSecundario == false)
                          ? Colors.grey[600]
                          : Colors.white,
                      fontSize: 15.0,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10.0,
                ),
                _crearBotonRegistro(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _texto(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            'Bienvenido de Nuevo',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: (prefs.colorSecundario == false)
                    ? Colors.grey[600]
                    : Colors.white,
                fontSize: 26.0,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _subtitulo(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            'Inicia Sesión Para Continuar',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: (prefs.colorSecundario == false)
                    ? Colors.grey[600]
                    : Colors.white,
                fontSize: 16.0,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget _crearEmail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller: _usernameController,
        keyboardType: TextInputType.emailAddress,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.grey[400]),
              gapPadding: 4.0),
          hintText: 'Usuario',
          hintStyle: TextStyle(
            color: (prefs.colorSecundario == false)
                ? Colors.grey[600]
                : Colors.white,
          ),
          suffixIcon: Icon(
            Icons.done_outline,
            color: Colors.lightBlueAccent[400],
          ),
          icon: Icon(
            Icons.account_box_outlined,
            color: Colors.lightBlueAccent[400],
          ),
        ),
      ),
    );
  }

  Widget _crearPassword(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        obscureText: true,
        controller: _passwordController,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            focusedBorder: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(30.0),
                borderSide: BorderSide(color: Colors.grey[400]),
                gapPadding: 4.0),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: (prefs.colorSecundario == false)
                  ? Colors.grey[600]
                  : Colors.white,
            ),
            suffixIcon:
                Icon(Icons.done_outline, color: Colors.lightBlueAccent[400]),
            icon: Icon(
              Icons.lock_open_outlined,
              color: Colors.lightBlueAccent[400],
            )),
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    return _circularProgress == true
        ? CircularProgressIndicator(
            strokeWidth: 2,
          )
        : RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 125.0, vertical: 15.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 114, 255, 1.0),
                    Color.fromRGBO(0, 198, 255, 1.0),
                  ],
                ),
              ),
              child: Text('Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )),
            ),
            elevation: 2.0,
            onPressed: _onPressed,
          );
  }

  Widget _crearBotonRegistro(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 110.0, vertical: 15.0),
        onPressed: () {
          Navigator.pushReplacementNamed(context, RegisterPage.routName);
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blueAccent[400],
              width: 2,
              style: BorderStyle.solid),
        ),
        child: Text(
          'Registrarse',
          style: TextStyle(
              color: (prefs.colorSecundario == false)
                  ? Colors.blueAccent[400]
                  : Colors.white,
              fontSize: 20.0,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
