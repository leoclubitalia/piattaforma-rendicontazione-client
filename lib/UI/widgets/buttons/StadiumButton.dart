import 'package:flutter/material.dart';


class StadiumButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final bool disabled;
  final double padding;
  final double minWidth;

  const StadiumButton({Key key, this.title, this.icon, this.onPressed, this.disabled = false, this.padding = 10, this.minWidth = 150}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.all(padding),
      child: ButtonTheme(
        minWidth: minWidth,
        height: 25.0,
        child: RaisedButton.icon(
          onPressed: () {
            if ( !disabled ) {
              onPressed();
            }
          },
          color: Theme.of(context).buttonColor,
          shape: StadiumBorder(),
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          icon: Icon(icon, color: Theme.of(context).accentColor),
          label: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }


}
