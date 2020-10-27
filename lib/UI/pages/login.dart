import 'package:RendicontationPlatformLeo_Client/UI/behaviors/GlobalState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LogIn extends StatefulWidget {
  LogIn({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogIn createState() => _LogIn();
}

class _LogIn extends GlobalState<LogIn> {

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