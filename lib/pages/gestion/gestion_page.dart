import 'dart:convert';
import 'dart:io';
import 'package:diseno_login/pages/home_page.dart';
import 'package:flutter/material.dart';
//paketes propios
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/dropdown/lista_accion_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_atiende_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_conclucion_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_postura_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_vivienda_widget.dart';
import 'package:diseno_login/widgets/posicion/posicion_widget.dart';
//packetes de terceros
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

void main() => runApp(GestionPage());

class GestionPage extends StatefulWidget {
  static final String routName = 'gestion';
  final String vivienda;
  final String atiende;
  final String postura;
  final String conclucion;
  final String accion;
  GestionPage(
      {this.vivienda,
      this.atiende,
      this.postura,
      this.conclucion,
      this.accion,
      Key key})
      : super(key: key);

  @override
  _GestionPageState createState() => _GestionPageState();
}

class _GestionPageState extends State<GestionPage> {
  final prefs = new PreferenciasUsuario();
  bool extraData;
  bool _circularProgress = false;
  final TextEditingController _telefonoController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _comentarioController =
      new TextEditingController();
  // ignore: avoid_init_to_null
  File imageFinal;
  void initState() {
    super.initState();
    extraData = false;
    prefs.respuestaNo = false;
    prefs.respuestaSi = false;
    _convertbasetofile();
    print(prefs.creditoRespaldo);
  }

  void _convertbasetofile() {
    final decodeBytes = base64Decode(prefs.foto);
    final file = File(prefs.rutaFoto);
    file.writeAsBytesSync(decodeBytes);
    setState(() {
      imageFinal = file;
    });
  }

  void _saveGestion() async {
    setState(() {
      _circularProgress = true;
    });
    if (_telefonoController.text.isNotEmpty) {
      if (_emailController.text.isNotEmpty) {
        prefs.telefono = _telefonoController.text.trim();
        prefs.email = _emailController.text.trim();
      }
    }
    prefs.comentario = _comentarioController.text.toUpperCase();
    final time = DateTime.now();
    prefs.horaFin = time.hour.toString() +
        ":" +
        time.minute.toString() +
        ":" +
        time.second.toString();
    final url =
        'http://187.162.64.236:9090/dombarreraapi/api/auth/guardar/gestion';
    if (prefs.credito != 'Sin Credito Buscado') {
      final body = {
        'usuario': '${prefs.username}',
        'credito': '${prefs.credito}',
        'vivienda': '${prefs.vivienda}',
        'atiende': '${prefs.atiende}',
        'postura': '${prefs.postura}',
        'conclucion': '${prefs.conclucion}',
        'accion': '${prefs.accion}',
        'latitud': '${prefs.latitude}',
        'longitud': '${prefs.longitude}',
        'hora_inicio': '${prefs.horaInicio}',
        'hora_fin': '${prefs.horaFin}',
        'foto': '${prefs.foto}',
        'telefono': '${prefs.telefono}',
        'email': '${prefs.email}',
        'comentario': '${prefs.comentario}'
      };
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'X-Request-With': 'XMLHhttpRequest',
          'Authorization': 'Bearer ${prefs.token}'
        },
        body: body,
      );
      if (response.statusCode == 201) {
        prefs.credito = "";
        prefs.creditoRespaldo = "";
        prefs.vivienda = "";
        prefs.atiende = "";
        prefs.postura = "";
        prefs.conclucion = "";
        prefs.accion = "";
        prefs.latitude = 0.0;
        prefs.longitude = 0.0;
        prefs.horaInicio = "";
        prefs.horaFin = "";
        prefs.foto = "";
        prefs.email = "";
        prefs.telefono = "";

        setState(() {
          _circularProgress = false;
        });
        Navigator.pushReplacementNamed(context, HomePage.routName);
      }
    } else {
      final body = {
        'usuario': '${prefs.username}',
        'credito': '${prefs.creditoRespaldo}',
        'vivienda': '${prefs.vivienda}',
        'atiende': '${prefs.atiende}',
        'postura': '${prefs.postura}',
        'conclucion': '${prefs.conclucion}',
        'accion': '${prefs.accion}',
        'latitud': '${prefs.latitude}',
        'longitud': '${prefs.longitude}',
        'hora_inicio': '${prefs.horaInicio}',
        'hora_fin': '${prefs.horaFin}',
        'foto': '${prefs.foto}',
        'telefono': '${prefs.telefono}',
        'email': '${prefs.email}',
        'comentario': '${prefs.comentario}'
      };
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'X-Request-With': 'XMLHhttpRequest',
          'Authorization': 'Bearer ${prefs.token}'
        },
        body: body,
      );
      if (response.statusCode == 201) {
        prefs.credito = "";
        prefs.creditoRespaldo = "";
        prefs.vivienda = "";
        prefs.atiende = "";
        prefs.postura = "";
        prefs.conclucion = "";
        prefs.accion = "";
        prefs.latitude = 0.0;
        prefs.longitude = 0.0;
        prefs.horaInicio = "";
        prefs.horaFin = "";
        prefs.foto = "";

        setState(() {
          _circularProgress = false;
        });
        Navigator.pushReplacementNamed(context, HomePage.routName);
      }
    }
  }

  final estiloTitulo = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  // ignore: missing_return
  Widget _dialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsOverflowButtonSpacing: 0.5,
          title: Text("Capturaras algun Telefono o E-mail"),
          actions: [
            FlatButton(
                onPressed: () {
                  setState(() {
                    extraData = false;
                  });
                  Navigator.pop(context, false);
                },
                child: Text('No')),
            FlatButton(
                onPressed: () {
                  setState(() {
                    extraData = true;
                    prefs.respuestaSi = true;
                  });
                  Navigator.pop(context, true);
                },
                child: Text('Si')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (prefs.colorSecundario == false)
          ? Colors.blue
          : Color.fromRGBO(52, 73, 94, 1.0),
      floatingActionButton: (prefs.vivienda != '' &&
              prefs.atiende != '' &&
              prefs.postura != '' &&
              prefs.conclucion != '' &&
              prefs.accion != '')
          ? Badge(
              position: BadgePosition.topStart(start: 30, top: -10.0),
              badgeContent: Text("1"),
              badgeColor: Colors.greenAccent,
              child: (extraData == true)
                  ? Text('')
                  : (prefs.respuestaSi == true)
                      ? Text('')
                      : FloatingActionButton(
                          onPressed: () {
                            _dialog(context);
                            //_saveGestion();
                          },
                          child: const Icon(Icons.mail_outline),
                          backgroundColor: Colors.cyan[600],
                        ),
            )
          : Text(''),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _crearImagen(context),
            _crearTitulo(),
            SizedBox(height: 0.0),
            PosicionWidget(),
            SizedBox(height: 0.5),
            _listaVivienda(),
            SizedBox(height: 0.5),
            _listaAtiende(),
            SizedBox(height: 0.5),
            _listaPostura(),
            SizedBox(height: 0.5),
            _listaConclucion(),
            SizedBox(height: 0.5),
            _listaAccion(),
            SizedBox(height: 1.5),
            (prefs.respuestaSi == true && prefs.respuestaNo == false)
                ? _inputTelefono(context)
                : Text(""),
            SizedBox(height: 1.0),
            (prefs.respuestaSi == true && prefs.respuestaNo == false)
                ? _inputEmail(context)
                : Text(""),
            SizedBox(height: 1.0),
            _inputComentario(context),
            SizedBox(height: 1.0),
            _crearBoton(context),
            SizedBox(height: 1.0),
          ],
        ),
      ),
    );
  }

  Widget _inputTelefono(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.5),
          Text("Numero Telefonico",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 10.5),
          TextField(
            controller: _telefonoController,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
              hintText: 'Telefono',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.add_ic_call,
                color: Colors.cyan[300],
              ),
              icon: Icon(
                Icons.phone,
                color: Colors.cyan[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputEmail(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.5),
          Text("Correro Electronico",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 10.5),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 30,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
              hintText: 'E-mail',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.alternate_email,
                color: Colors.cyan[300],
              ),
              icon: Icon(
                Icons.mark_email_read,
                color: Colors.cyan[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputComentario(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.5),
          Text("Comentario de Gestion",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800)),
          SizedBox(height: 10.5),
          TextField(
            controller: _comentarioController,
            keyboardType: TextInputType.text,
            maxLength: 100,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
              hintText: 'Comentario',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.edit,
                color: Colors.cyan[300],
              ),
              icon: Icon(
                Icons.post_add,
                color: Colors.cyan[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearImagen(BuildContext context) {
    return (prefs.foto == '')
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

  Widget _listaVivienda() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.apartment,
              color: Colors.cyan[300],
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan[300]),
            title: Text('Tipo de Vivienda'),
            subtitle: (prefs.vivienda == '')
                ? Text('Selecciona el tipo de Vivienda')
                : Text("${prefs.vivienda}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaVivienda(),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listaAtiende() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.record_voice_over,
              color: Colors.cyan[300],
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan[300]),
            title: Text('Quien de Atiende'),
            subtitle: (prefs.atiende == '')
                ? Text('Selecciona Quien Atiende')
                : Text("${prefs.atiende}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaAtiende(vivienda: widget.vivienda),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listaPostura() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.psychology,
              color: Colors.cyan[300],
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan[300]),
            title: Text('Quien Postura Tiene'),
            subtitle: (prefs.postura == '')
                ? Text('Selecciona Que Postura Tiene')
                : Text("${prefs.postura}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaPostura(
                      vivienda: widget.vivienda, atiende: widget.atiende),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listaConclucion() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.emoji_people,
              color: Colors.cyan[300],
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan[300]),
            title: Text('Quien Conclucion Obtuvo'),
            subtitle: (prefs.conclucion == '')
                ? Text('Selecciona Que Conclucion Obtuvo')
                : Text("${prefs.conclucion}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaConclucion(
                      vivienda: widget.vivienda, postura: widget.postura),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _listaAccion() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(top: 15.0, left: 0.0, right: 0.0),
          child: ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              color: Colors.cyan[300],
              size: 45.0,
            ),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.cyan[300]),
            title: Text('Quien Accion Obtuvo'),
            subtitle: (prefs.conclucion == '')
                ? Text('Selecciona Que Accion Obtuvo')
                : Text("${prefs.accion}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListaAccion(
                    vivienda: widget.vivienda,
                    postura: widget.postura,
                    conclucion: widget.conclucion,
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _crearTitulo() {
    return (prefs.foto == '')
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
                      color: Colors.cyan[300], size: 45.0),
                  Text(
                      (prefs.credito == 'Sin Credito Buscado')
                          ? '${prefs.creditoRespaldo}'
                          : '${prefs.credito}',
                      style: TextStyle(fontSize: 15.0, color: Colors.grey[700]))
                ],
              ),
            ),
          );
  }

  Widget _crearBoton(BuildContext context) {
    return _circularProgress == true
        ? CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.green,
          )
        : RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 140.0, vertical: 15.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.greenAccent,
                    Colors.cyan[300],
                  ],
                ),
              ),
              child: Text('Guardar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  )),
            ),
            elevation: 3.0,
            onPressed: _saveGestion,
          );
  }
}
