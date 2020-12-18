import 'package:flutter/material.dart';


class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  const CircularIconButton({Key key, this.icon, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: FlatButton(
        onPressed: onPressed,
        minWidth: 0,
        color: Theme.of(context).buttonColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Icon(icon, color: Theme.of(context).accentColor),
        padding: EdgeInsets.all(18.0),
        shape: CircleBorder(),
      ),
    );
  }


}