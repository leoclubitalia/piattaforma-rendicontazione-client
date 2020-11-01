import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InputField extends StatelessWidget {
  final String labelText;
  final Function onSubmit;
  final TextEditingController controller;
  final TextInputType keyboardType;


  const InputField({Key key, this.labelText, this.controller, this.onSubmit, this.keyboardType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number ? <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ] : null,
        onSubmitted: onSubmit,
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
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).unselectedWidgetColor,
          ),
        )
      ),
    );
  }


}