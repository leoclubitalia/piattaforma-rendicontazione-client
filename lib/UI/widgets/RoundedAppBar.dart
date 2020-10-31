import 'package:flutter/material.dart';


class RoundedAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String title;
  final Widget bottom;


  RoundedAppBar({Key key, this.title, this.bottom}) : preferredSize = Size.fromHeight(50.0), super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      bottom: bottom,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }


}