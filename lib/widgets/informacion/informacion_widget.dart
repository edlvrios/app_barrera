import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:diseno_login/share_prefs/preferencias_usuario.dart';

class InformacionWidget extends StatefulWidget {
  InformacionWidget({Key key}) : super(key: key);

  @override
  _InformacionWidgetState createState() => _InformacionWidgetState();
}

class _InformacionWidgetState extends State<InformacionWidget> {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    final page = ({Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: MediaQuery.of(context).size.height - (2 * 30))
        .scrollable();
    return <Widget>[
      Text(
        'Informacion del Credito',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
      ).alignment(Alignment.center).padding(bottom: 20),
      Settings(),
    ].toColumn().parent(page);
  }
}

class SettingsItemModel {
  final IconData icon;
  final Color color;
  final String title;
  final String description;
  const SettingsItemModel({
    @required this.color,
    @required this.description,
    @required this.icon,
    @required this.title,
  });
}

const List<SettingsItemModel> settingsItems = [
  SettingsItemModel(
    icon: Icons.location_on,
    color: Color.fromRGBO(0, 198, 255, 1.0),
    title: 'Domicilio',
    description: 'Informacion de la vivienda',
  ),
  SettingsItemModel(
    icon: Icons.request_page,
    color: Color.fromRGBO(0, 198, 255, 1.0),
    title: 'Datos Financieros',
    description: 'Informacion de Adeudo',
  ),
  SettingsItemModel(
    icon: Icons.library_books,
    color: Color.fromRGBO(0, 198, 255, 1.0),
    title: 'Convenios',
    description: 'Convenios Activos Para El Credito',
  ),
  SettingsItemModel(
    icon: Icons.verified,
    color: Color.fromRGBO(0, 198, 255, 1.0),
    title: 'Soluciones',
    description: 'Informacion para Solucion del Credito',
  ),
  SettingsItemModel(
    icon: Icons.data_usage,
    color: Color.fromRGBO(0, 198, 255, 1.0),
    title: 'Gestion',
    description: 'Genera la Gestion Para el Credito Buscado',
  ),
];

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => settingsItems
      .map((settingsItem) => SettingsItem(
            settingsItem.icon,
            settingsItem.color,
            settingsItem.title,
            settingsItem.description,
          ))
      .toList()
      .toColumn();
}

class SettingsItem extends StatefulWidget {
  SettingsItem(this.icon, this.iconBgColor, this.title, this.description);

  final IconData icon;
  final Color iconBgColor;
  final String title;
  final String description;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    final settingsItem = ({Widget child}) => Styled.widget(child: child)
        .alignment(Alignment.center)
        .borderRadius(all: 15)
        .ripple()
        .backgroundColor(Colors.white, animate: true)
        .clipRRect(all: 25) // clip ripple
        .borderRadius(all: 25, animate: true)
        .elevation(
          pressed ? 0 : 20,
          borderRadius: BorderRadius.circular(25),
          shadowColor: Color(0x30000000),
        ) // shadow borderRadius
        .constrained(height: 80)
        .padding(vertical: 12) // margin
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTapDown: (details) => print('tapDown'),
          onTap: () => print('onTap'),
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 180), Curves.easeOut);

    final Widget icon = Icon(widget.icon, size: 20, color: Colors.white)
        .padding(all: 12)
        .decorated(
          color: widget.iconBgColor,
          borderRadius: BorderRadius.circular(30),
        )
        .padding(left: 15, right: 10);

    final Widget title = Text(
      widget.title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ).padding(bottom: 5);

    final Widget description = Text(
      widget.description,
      style: TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );

    return settingsItem(
      child: <Widget>[
        icon,
        <Widget>[
          title,
          description,
        ].toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ].toRow(),
    );
  }
}
