import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  static final String routeName = 'informacion';
  final String credito;
  InfoPage({this.credito, Key key}) : super(key: key);
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("${widget.credito}"));
  }
}
