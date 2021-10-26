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

  get creditoRespaldo {
    return _prefs.getString('creditoRespaldo') ?? '';
  }

  set creditoRespaldo(String value) {
    _prefs.setString('creditoRespaldo', value);
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

  get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs.setString('telefono', value);
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get comentario {
    return _prefs.getString('comentario') ?? '';
  }

  set comentario(String value) {
    _prefs.setString('comentario', value);
  }

  get contador {
    return _prefs.getInt('contador') ?? 0;
  }

  set contador(int value) {
    _prefs.setInt('contador', value);
  }

  get respuestaSi {
    return _prefs.getBool('respuestaSi') ?? false;
  }

  set respuestaSi(bool value) {
    _prefs.setBool('respuestaSi', value);
  }

  get respuestaNo {
    return _prefs.getBool('respuestaNo') ?? false;
  }

  set respuestaNo(bool value) {
    _prefs.setBool('respuestaNo', value);
  }

  get responseCode {
    return _prefs.getInt('responseCode') ?? 0;
  }

  set responseCode(int value) {
    _prefs.setInt('responseCode', value);
  }

  get fakeGps {
    return _prefs.getBool('fakeGps') ?? false;
  }

  set fakeGps(bool value) {
    _prefs.setBool('fakeGps', value);
  }

  get nameFakeApp {
    return _prefs.getString('nameFakeApp') ?? '';
  }

  set nameFakeApp(String value) {
    _prefs.setString('nameFakeApp', value);
  }

  //Sincronizacion de datos
  get syncAsignacion {
    return _prefs.getBool('syncAsignacion') ?? false;
  }

  set syncAsignacion(bool value) {
    _prefs.setBool('syncAsignacion', value);
  }

  get syncVivienda {
    return _prefs.getBool('syncVivienda') ?? false;
  }

  set syncVivienda(bool value) {
    _prefs.setBool('syncVivienda', value);
  }

  get syncAtiende {
    return _prefs.getBool('syncAtiende') ?? false;
  }

  set syncAtiende(bool value) {
    _prefs.setBool('syncAtiende', value);
  }

  get syncPostura {
    return _prefs.getBool('syncPostura') ?? false;
  }

  set syncPostura(bool value) {
    _prefs.setBool('syncPostura', value);
  }

  get syncAccion {
    return _prefs.getBool('syncAccion') ?? false;
  }

  set syncAccion(bool value) {
    _prefs.setBool('syncAccion', value);
  }

  get syncConclucion {
    return _prefs.getBool('syncConclucion') ?? false;
  }

  set syncConclucion(bool value) {
    _prefs.setBool('syncConclucion', value);
  }
}
