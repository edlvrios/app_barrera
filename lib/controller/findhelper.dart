import 'package:diseno_login/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FindHelper {
  String server = 'http://187.162.64.236:9090/dombarreraapi/api/auth';
  var status;
  var token;

  Future<dynamic> getCreditoZona() async {
    final prefs = new PreferenciasUsuario();
    String server = 'http://187.162.64.236:9090/dombarreraapi/api/auth';
    String url = "$server/guardar/gestiones?username=${prefs.username}";
    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      'X-Request-With': 'XMLHhttpRequest',
      'Authorization': 'Bearer ${prefs.token}'
    });
    final data = json.decode(response.body);
    return data.toString();
  }
}
