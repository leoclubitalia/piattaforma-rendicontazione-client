import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class LeoBigBoldTitleStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.bold;
  @override
  double get fontSize => 30;

}

class LeoBigTitleStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.w300;

}

class LeoTitleStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.w200;

}

class LeoParagraphStyle extends TextStyle {

  @override
  FontWeight get fontWeight => FontWeight.w300;
  @override
  Color get color => Colors.grey;

}
