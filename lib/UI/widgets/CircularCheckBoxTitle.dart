import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';


class CircularCheckBoxTitle extends StatelessWidget {
  String title;
  bool value;
  Function onChanged;


  CircularCheckBoxTitle({Key key, this.title, this.value, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row (
      children: [
        CircularCheckBox(
          checkColor: Theme.of(context).primaryColor,
          activeColor: Theme.of(context).buttonColor,
          value: value,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: onChanged,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 11,
          ),
        ),
      ],
    );
  }


}