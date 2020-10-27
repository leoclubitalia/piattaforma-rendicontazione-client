import 'package:flutter/material.dart';


class StadiumButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

  const StadiumButton({Key key, this.title, this.icon, this.onPressed, this.disabled = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: EdgeInsets.all(10),
      child: ButtonTheme(
        minWidth: 150.0,
        height: 25.0,
        child: RaisedButton.icon(
          onPressed: () {
            if ( !disabled ) {
              onPressed();
            }
          },
          color: Theme.of(context).buttonColor,
          shape: StadiumBorder(),
          padding: EdgeInsets.all(20),
          icon: Icon(icon, color: Theme.of(context).indicatorColor),
          label: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).indicatorColor,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }


}
