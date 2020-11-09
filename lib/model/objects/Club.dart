import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';


class Club {
  int id;
  String name;
  String email;
  City city;
  District district;
  DateTime foundationDate;
  Quantity quantityServices;
  Quantity quantityActivities;


  Club({this.id, this.name, this.email, this.city, this.district, this.foundationDate, this.quantityServices, this.quantityActivities});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      city: City.fromJson(json['city']),
      district: District.fromJson(json['district']),
      foundationDate: DateTime.fromMillisecondsSinceEpoch(json['foundationDate']),
    );
  }

  Map<String, String> toJson() => {
    'id': id.toString(),
    //'name': name, unnecessary
    //'email': email, unnecessary
    //'city': city.toJson().toString(), unnecessary
    //'district': district.toJson().toString(), unnecessary
  };

  @override
  String toString() {
    return name;
  }


}
