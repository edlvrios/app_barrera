import 'package:diseno_login/controller/authhelper.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:flutter/material.dart';

import 'package:diseno_login/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  static final String routName = 'register';
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthHelper authHelper = new AuthHelper();
  final prefs = new PreferenciasUsuario();
  bool _circularProgress = false;
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _zonaController = new TextEditingController();
  _onPressed() {
    setState(() {
      if (_usernameController.text.trim().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty &&
          _emailController.text.trim().isNotEmpty &&
          _nameController.text.trim().toUpperCase().isNotEmpty &&
          _zonaController.text.trim().toUpperCase().isNotEmpty) {
        authHelper
            .registerData(
                _nameController.text.trim().toUpperCase(),
                _usernameController.text.trim(),
                _emailController.text.trim(),
                _passwordController.text.trim(),
                _zonaController.text.trim())
            .whenComplete(() {
          if (authHelper.status == true) {
            _showDialog('Error', 'Verifica Tu Email o Password', 'Cerrar');
          } else {
            Navigator.pushReplacementNamed(context, LoginPage.routName);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: (prefs.colorSecundario == false)
            ? Colors.white
            : Color.fromRGBO(52, 73, 94, 1.0),
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.lightBlueAccent[400]),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, LoginPage.routName),
        ),
      ),
      backgroundColor: (prefs.colorSecundario == false)
          ? Colors.white
          : Color.fromRGBO(52, 73, 94, 1.0),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          _registerForm(context),
        ],
      ),
    );
  }

  Widget _registerForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 70.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/Color-01.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                _texto(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearNombre(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearZona(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearUsuario(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearEmail(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearPassword(context),
                SizedBox(
                  height: 30.0,
                ),
                _crearBoton(context),
              ],
            ),
          )
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
            'Registra tus datos!',
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

  Widget _crearNombre(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller: _nameController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
          focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.grey[400]),
              gapPadding: 4.0),
          hintText: 'Nombre Completo',
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
            Icons.face,
            color: Colors.lightBlueAccent[400],
          ),
        ),
      ),
    );
  }

  Widget _crearZona(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller: _zonaController,
        keyboardType: TextInputType.name,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          focusedBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.grey[400]),
              gapPadding: 4.0),
          hintText: 'Estado Donde Vives',
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
            Icons.my_location,
            color: Colors.lightBlueAccent[400],
          ),
        ),
      ),
    );
  }

  Widget _crearUsuario(BuildContext context) {
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

  Widget _crearEmail(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller: _emailController,
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
          hintText: 'Email',
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
            Icons.alternate_email,
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
        controller: _passwordController,
        obscureText: true,
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
              Icons.lock,
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
              child: Text(
                'Registrar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            elevation: 2.0,
            onPressed: () {
              _onPressed();
            },
          );
  }

  void _showDialog(String title, String content, String textButton) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new RaisedButton(
              child: new Text(
                textButton,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
