import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InputDropdown extends StatelessWidget {
  final String labelText;
  final String defaultValue;
  final List<String> items;
  final Function onChanged;
  final TextEditingController controller;


  const InputDropdown({Key key, this.labelText, this.controller, this.onChanged, this.defaultValue, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.text = defaultValue;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: TextField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^$')),
            ],
            onTap: () {},
            controller: controller,
            cursorColor: Theme.of(context).hoverColor,
            style: TextStyle(height: 1.0),
            decoration: InputDecoration(
              fillColor: Theme.of(context).primaryColor,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).unselectedWidgetColor,
                  )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
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
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 9, 10, 0),
          child: DropdownButton<String>(
            isExpanded: true,
            underline: Container(
              height: 0,
            ),
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }


}