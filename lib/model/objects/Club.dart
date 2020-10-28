import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';


class Club {
  int id;
  String name;
  String email;
  City city;
  District district;


  Club({this.id, this.name, this.email, this.city, this.district});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      city: json['city'],
      district: json['district']
    );
  }


}