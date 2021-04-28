import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {
  //patron singleton
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get ultimaPagina {
    return _prefs.getString('ruta') ?? 'login';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ruta', value);
  }

  get latitude {
    return _prefs.getDouble('latitude') ?? 0.0;
  }

  set latitude(double value) {
    _prefs.setDouble('latitude', value);
  }

  get longitude {
    return _prefs.getDouble('longitude') ?? 0.0;
  }

  set longitude(double value) {
    _prefs.setDouble('longitude', value);
  }

  get credito {
    return _prefs.getString('credito') ?? 'Sin Credito Buscado';
  }

  set credito(String value) {
    _prefs.setString('credito', value);
  }

  get colorSecundario {
    return _prefs.getBool('color') ?? false;
  }

  set colorSecundario(bool value) {
    _prefs.setBool('color', value);
  }

  get username {
    return _prefs.getString('username') ?? 'Untitle';
  }

  set username(String value) {
    _prefs.setString('username', value);
  }

  get name {
    return _prefs.getString('name') ?? 'Untitle';
  }

  set name(String value) {
    _prefs.setString('name', value);
  }

  get zona {
    return _prefs.getString('zona') ?? 'Estado de Mexico';
  }

  set zona(String value) {
    _prefs.setString('zona', value);
  }

  get password {
    return _prefs.getString('password') ?? '';
  }

  set password(String value) {
    _prefs.setString('password', value);
  }

  get vivienda {
    return _prefs.getString('vivienda') ?? '';
  }

  set vivienda(String value) {
    _prefs.setString('vivienda', value);
  }

  get atiende {
    return _prefs.getString('atiende') ?? '';
  }

  set atiende(String value) {
    _prefs.setString('atiende', value);
  }

  get postura {
    return _prefs.getString('postura') ?? '';
  }

  set postura(String value) {
    _prefs.setString('postura', value);
  }

  get conclucion {
    return _prefs.getString('conclucion') ?? '';
  }

  set conclucion(String value) {
    _prefs.setString('conclucion', value);
  }

  get accion {
    return _prefs.getString('accion') ?? '';
  }

  set accion(String value) {
    _prefs.setString('accion', value);
  }

  get token {
    return _prefs.getString('token') ?? 'sin Token';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get foto {
    return _prefs.getString('foto') ?? '';
  }

  set foto(String value) {
    _prefs.setString('foto', value);
  }

  get rutaFoto {
    return _prefs.getString('rutaFoto') ?? '';
  }

  set rutaFoto(String value) {
    _prefs.setString('rutaFoto', value);
  }

  get horaInicio {
    return _prefs.getString('horaInicio') ?? '00:00:00';
  }

  set horaInicio(String value) {
    _prefs.setString('horaInicio', value);
  }

  get horaFin {
    return _prefs.getString('horaFin') ?? '00:00:00';
  }

  set horaFin(String value) {
    _prefs.setString('horaFin', value);
  }
}
