import 'dart:convert';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/DateFormatter.dart';


class Activity {
  int id;
  String title;
  String description;
  DateTime date;
  int quantityLeo;
  bool lionsParticipation;
  SatisfactionDegree satisfactionDegree;
  City city;
  Club club;
  List<TypeActivity> typesActivity;
  

  Activity({this.id, this.title, this.description, this.date, this.quantityLeo, this.lionsParticipation, this.satisfactionDegree, this.city, this.club, this.typesActivity});

  factory Activity.fromJson(Map<String, dynamic> json) {
    List<TypeActivity> typesActivity = List();
    for ( Map<String, dynamic> rawTypeActivity in json['typesActivity'] ) {
      typesActivity.add(TypeActivity.fromJson(rawTypeActivity));
    }
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateFormatter.fromString(json['date']),
      quantityLeo: json['quantityLeo'],
      lionsParticipation: json['lionsParticipation'],
      satisfactionDegree: SatisfactionDegree.fromJson(json['satisfactionDegree']),
      city: City.fromJson(json['city']),
      club: Club.fromJson(json['club']),
      typesActivity: typesActivity,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'quantityLeo': quantityLeo,
    'lionsParticipation': lionsParticipation,
    'satisfactionDegree': satisfactionDegree.toJson(),
    'city': city.toJson(),
    'club': club.toJson(),
    'typesActivity': jsonEncode(typesActivity),
  };


}