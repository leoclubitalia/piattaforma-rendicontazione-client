import 'package:flutter/material.dart';


class RoundedDialog extends StatelessWidget {
  final Widget title;
  final Widget body;


  const RoundedDialog({Key key, this.title, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: title,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      children: [
        body,
      ],
    );
  }


}