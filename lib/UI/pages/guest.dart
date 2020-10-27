import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Guest extends StatefulWidget {
  Guest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Guest createState() => _Guest();
}

class _Guest extends GlobalState<Guest> {

  @override
  void refreshState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }

}