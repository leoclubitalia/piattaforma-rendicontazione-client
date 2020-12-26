import 'package:RendicontationPlatformLeo_Client/model/objects/Cap.dart';


class City {
  int id;
  String name;
  List<Cap> caps;


  City({this.id, this.name, this.caps});

  factory City.fromJson(Map<String, dynamic> json) {
    List<Cap> caps = [];
    if ( json['caps'] != null ) {
      for ( Map<String, dynamic> rawCap in json['caps'] ) {
        caps.add(Cap.fromJson(rawCap));
      }
    }
    return City(
      id: json['id'],
      name: json['name'],
      caps: caps,
    );
  }

  Map<String, String> toJson() => {
    'id': id.toString(),
    //'name': name, unnecessary
    //'caps': caps.map((e) => e.toJson()).toList(), unnecessary
  };

  @override
  String toString() {
    return name + " " + caps.toString();
  }


}