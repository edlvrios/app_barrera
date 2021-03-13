import 'package:flutter/material.dart';

class InternetWidget extends StatelessWidget {
  const InternetWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.signal_wifi_off),
    );
  }
}
