import 'package:flutter/material.dart';


class InputButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextEditingController controller;
  final double padding;


  const InputButton({Key key, this.text, this.controller, this.onPressed, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
          onTap: onPressed,
          controller: controller,
          cursorColor: Theme.of(context).hoverColor,
          style: TextStyle(height: 1.0),
          decoration: InputDecoration(
            fillColor: Theme.of(context).primaryColor,
            focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(30.0),
                borderSide: BorderSide(
                  color: Theme.of(context).unselectedWidgetColor,
                )
            ),
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Theme.of(context).unselectedWidgetColor,
              ),
            ),
            labelText: text,
            labelStyle: TextStyle(
              color: Theme.of(context).unselectedWidgetColor,
            ),
          )
      ),
    );
  }


}