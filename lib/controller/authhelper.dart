import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthHelper {
  String serverUrl = 'http://187.162.64.236:9090/dombarreraapi/api/auth';
  var status;
  var token;
  /*
  *Inicio de Sesion
  *Variables recibidas
  *(string) username
  *(string) password
  */
  loginData(String username, String password) async {
    String miUrl = "$serverUrl/login";
    final response = await http.post(
      miUrl,
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: {"username": "$username", "password": "$password"},
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);
    final prefs = new PreferenciasUsuario();
    prefs.token = data['access_token'];
    if (prefs.token != 'sin Token') {
      String miUrl = "$serverUrl/user";
      final response = await http.get(miUrl, headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer ${prefs.token}'
      });
      final data = json.decode(response.body);
      prefs.username = data['username'];
      prefs.name = data['name'];
      prefs.zona = data['zona'];
    }
  }

  /*
  *Cerrar sesion
  *Variables recibidas
  *(string) username
  *(string) password
  */
  logoutData() async {
    final prefs = new PreferenciasUsuario();
    String miUrl = "$serverUrl/logout";
    prefs.token = '';
    final response = await http.get(
      miUrl,
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $prefs.token'
      },
    );
    return json.decode(response.body);
  }

  /*
  *Registro de Usuario
  *Variables recibidas
  *(string) name
  *(string) username
  *(string) email
  *(string) password
  */
  registerData(String name, String username, String email, String password,
      String zona) async {
    String miUrl = "$serverUrl/signup";
    final response = await http.post(
      miUrl,
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      },
      body: {
        "name": '$name',
        'username': '$username',
        'email': '$email',
        'password': '$password',
        'zona': '$zona',
      },
    );
    status = response.body.contains('error');

    var data = json.decode(response.body);
    final prefs = new PreferenciasUsuario();
    prefs.name = name;
    prefs.username = username;
    print(status);
    if (status) {
      print('${data["error"]}');
    } else {
      print('$data');
    }
  }
}
