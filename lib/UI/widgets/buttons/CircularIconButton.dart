import 'package:flutter/material.dart';


class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const CircularIconButton({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Theme.of(context).buttonColor,
      child: Icon(icon, color: Theme.of(context).accentColor),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    );
  }


}