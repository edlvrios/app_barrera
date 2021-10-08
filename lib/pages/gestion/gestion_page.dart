import 'dart:convert';
import 'dart:io';
import 'package:diseno_login/pages/home_page.dart';
import 'package:diseno_login/widgets/posicion/posicion_widget.dart';
import 'package:flutter/material.dart';
//paketes propios
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:diseno_login/widgets/dropdown/lista_accion_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_atiende_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_conclucion_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_postura_widget.dart';
import 'package:diseno_login/widgets/dropdown/lista_vivienda_widget.dart';
//packetes de terceros
import 'package:http/http.dart' as http;
//import 'package:badges/badges.dart';

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
    if (prefs.vivienda == "" ||
        prefs.atiende == "" ||
        prefs.postura == "" ||
        prefs.conclucion == "" ||
        prefs.accion == "" ||
        prefs.comentario == "") {
      _dialog(context, "Te faltan campos por seleccionar");
      setState(() {
        _circularProgress = false;
      });
    } else {
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
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomePage.routName, (Route<dynamic> route) => false);
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
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomePage.routName, (Route<dynamic> route) => false);
          //Navigator.pushAndRemoveUntil(context, Route(),(Route<dynamic> route)=>false);
        }
      }
    }
  }

  final estiloTitulo = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  // ignore: missing_return
  Widget _dialog(BuildContext context, String mensaje) {
    showDialog(
      barrierDismissible: false,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsOverflowButtonSpacing: 0.5,
          title: Text('Atencion'),
          content: Text(mensaje),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context, false), // passing false
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _crearImagen(context),
            _crearTitulo(),
            PosicionWidget(),
            _listaVivienda(),
            _listaAtiende(),
            _listaPostura(),
            _listaConclucion(),
            _listaAccion(),
            (prefs.vivienda != '' &&
                    prefs.atiende != '' &&
                    prefs.postura != '' &&
                    prefs.conclucion != "" &&
                    prefs.accion != '')
                ? _inputTelefono(context)
                : Text(""),
            (prefs.vivienda != '' &&
                    prefs.atiende != '' &&
                    prefs.postura != '' &&
                    prefs.conclucion != "" &&
                    prefs.accion != '')
                ? _inputEmail(context)
                : Text(""),
            (prefs.vivienda != '' &&
                    prefs.atiende != '' &&
                    prefs.postura != '' &&
                    prefs.conclucion != "" &&
                    prefs.accion != '')
                ? _inputComentario(context)
                : Text(''),
            (prefs.vivienda != '' &&
                    prefs.atiende != '' &&
                    prefs.postura != '' &&
                    prefs.conclucion != "" &&
                    prefs.accion != '')
                ? _crearBoton(context)
                : Text(""),
            SizedBox(height: 0.0),
          ],
        ),
      ),
    );
  }

  Widget _inputTelefono(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
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
                color: Colors.blueGrey[300],
              ),
              icon: Icon(
                Icons.phone,
                color: Colors.blueGrey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputEmail(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Correro Electronico",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800)),
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
                color: Colors.blueGrey[300],
              ),
              icon: Icon(
                Icons.mark_email_read,
                color: Colors.blueGrey[300],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputComentario(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, bottom: 0.5),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.0),
          Text("Comentario de Gestion *",
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              hintText: 'Comentario',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.edit,
                color: Colors.blueGrey[300],
              ),
              icon: Icon(
                Icons.post_add,
                color: Colors.blueGrey[300],
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
          decoration: BoxDecoration(
              color:
                  (prefs.vivienda == '') ? Colors.red[300] : Colors.green[300]),
          margin: EdgeInsets.only(
            top: 5.0,
            left: 0.0,
            right: 0.0,
          ),
          child: ListTile(
            leading: Icon(
              Icons.apartment,
              color: Colors.white,
              size: 45.0,
            ),
            trailing: Icon(
              (prefs.vivienda == '') ? Icons.keyboard_arrow_right : Icons.check,
              color: Colors.white,
            ),
            title: Text(
              'Tipo de Vivienda  *',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: (prefs.vivienda == '')
                ? Text('Selecciona el tipo de Vivienda')
                : Text(
                    "${prefs.vivienda}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
            onTap: () {
              if (prefs.vivienda == '') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaVivienda(),
                  ),
                );
              } else {}
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
          decoration: BoxDecoration(
            color: (prefs.atiende == '') ? Colors.red[300] : Colors.green[300],
          ),
          margin: EdgeInsets.only(
            top: 5.0,
            left: 0.0,
            right: 0.0,
          ),
          child: ListTile(
            leading: Icon(
              Icons.record_voice_over,
              color: Colors.white,
              size: 45.0,
            ),
            trailing: Icon(
              (prefs.atiende == '') ? Icons.keyboard_arrow_right : Icons.check,
              color: Colors.white,
            ),
            title: Text(
              '¿Quien Atiende?  *',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: (prefs.atiende == '')
                ? Text(
                    'Selecciona Quien Atiende',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  )
                : Text("${prefs.atiende}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    )),
            onTap: () {
              if (prefs.vivienda == '') {
                _dialog(context, "Te falta Seleccionar la Vivienda");
              } else {
                if (prefs.atiende == '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaAtiende(
                        vivienda: widget.vivienda,
                      ),
                    ),
                  );
                }
              }
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
          decoration: BoxDecoration(
              color:
                  (prefs.postura == '') ? Colors.red[300] : Colors.green[300]),
          margin: EdgeInsets.only(
            top: 5.0,
            left: 0.0,
            right: 0.0,
          ),
          child: ListTile(
            leading: Icon(
              Icons.psychology,
              color: Colors.white,
              size: 45.0,
            ),
            trailing: Icon(
              (prefs.postura == '') ? Icons.keyboard_arrow_right : Icons.check,
              color: Colors.white,
            ),
            title: Text(
              '¿Que Postura Tiene?  *',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: (prefs.postura == '')
                ? Text(
                    'Selecciona Que Postura Tiene',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  )
                : Text("${prefs.postura}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    )),
            onTap: () {
              if (prefs.atiende == "") {
                _dialog(context, "Te falta Seleccionar la Quien Atiende");
              } else {
                if (prefs.postura == '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaPostura(
                        vivienda: widget.vivienda,
                        atiende: widget.atiende,
                      ),
                    ),
                  );
                } else {}
              }
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
          decoration: BoxDecoration(
              color: (prefs.conclucion == '')
                  ? Colors.red[300]
                  : Colors.green[300]),
          margin: EdgeInsets.only(
            top: 5.0,
            left: 0.0,
            right: 0.0,
          ),
          child: ListTile(
            leading: Icon(
              Icons.emoji_people,
              color: Colors.white,
              size: 45.0,
            ),
            trailing: Icon(
              (prefs.conclucion == '')
                  ? Icons.keyboard_arrow_right
                  : Icons.check,
              color: Colors.white,
            ),
            title: Text(
              '¿Que Conclucion Obtuviste?  *',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: (prefs.conclucion == '')
                ? Text(
                    'Selecciona Que Conclucion Obtuvo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  )
                : Text("${prefs.conclucion}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    )),
            onTap: () {
              if (prefs.postura == "") {
                _dialog(context, "Te falta seleccionar que Que Postura");
              } else {
                if (prefs.conclucion == '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListaConclucion(
                        vivienda: widget.vivienda,
                        postura: widget.postura,
                      ),
                    ),
                  );
                } else {}
              }
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
          decoration: BoxDecoration(
              color:
                  (prefs.accion == '') ? Colors.red[300] : Colors.green[300]),
          margin: EdgeInsets.only(
            top: 5.0,
            left: 0.0,
            right: 0.0,
          ),
          child: ListTile(
            leading: Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 45.0,
            ),
            trailing: Icon(
              (prefs.accion == '') ? Icons.keyboard_arrow_right : Icons.check,
              color: Colors.white,
            ),
            title: Text(
              '¿Que Accion Se Obtuvo?  *',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: (prefs.accion == '')
                ? Text(
                    'Selecciona Que Accion Obtuvo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  )
                : Text("${prefs.accion}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    )),
            onTap: () {
              if (prefs.conclucion == '') {
                _dialog(
                    context, "Te falta seleccionar que Conclucion Obtiviste");
              } else {
                if (prefs.accion == '') {
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
                } else {}
              }
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
                left: 30.0,
                right: 30.0,
                top: 5.0,
                bottom: 30.0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Credito Gestionado', style: estiloTitulo),
                        Text('Los campos con * son obligatorios',
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.red[400])),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.account_circle,
                    color: Colors.blueGrey[300],
                    size: 45.0,
                  ),
                  Text(
                    (prefs.credito == 'Sin Credito Buscado')
                        ? '${prefs.creditoRespaldo}'
                        : '${prefs.credito}',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget _crearBoton(BuildContext context) {
    return _circularProgress == true
        ? CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.blueGrey,
          )
        : Container(
            width: 300.0,
            child: ElevatedButton(
              onPressed: _saveGestion,
              child: Text('Guardar'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[900],
                onPrimary: Colors.white,
                onSurface: Colors.grey,
                elevation: 3.0,
              ),
            ),
          );
  }
}
