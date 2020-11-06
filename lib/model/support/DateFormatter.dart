import 'package:intl/intl.dart';


extension DateFormatter on DateTime {


  String toStringUnslashed() {
    NumberFormat formatter = new NumberFormat("00");
    return formatter.format(day) + formatter.format(month) + formatter.format(year);
  }

  String toStringSlashed() {
    NumberFormat formatter = new NumberFormat("00");
    return formatter.format(day) + "/" + formatter.format(month) + "/" + formatter.format(year);
  }



}