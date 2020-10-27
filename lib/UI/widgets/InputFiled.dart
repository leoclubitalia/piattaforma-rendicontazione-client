import 'package:flutter/material.dart';


class InputField extends StatelessWidget {
  final String hintText;
  final Function onSubmit;
  final TextEditingController controller;


  const InputField({Key key, this.hintText, this.controller, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmit,
      controller: controller,
      cursorColor: Theme.of(context).hoverColor,
      style: TextStyle(height: 1.0),
      decoration: InputDecoration(
        fillColor: Theme.of(context).primaryColor,
        focusedBorder: OutlineInputBorder(
            borderRadius: new BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Theme.of(context).hoverColor,
            )
        ),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Theme.of(context).hoverColor,
          ),
        ),
        hintText: hintText,
      )
    );
  }


}