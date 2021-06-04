import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import '../model/credito.dart';

class CreditoModel extends Model {
  List<Credito> credito = [];

  void fetchCreditto() async {
    try {
      final response =
          await http.get('http://187.162.64.236:9090/dombarreraapi/api/auth/');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
