import 'dart:convert';

import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';


class Activity {
  int id;
  String title;
  String description;
  DateTime date;
  int quantityLeo;
  bool lionsParticipation;
  int satisfactionDegree;
  City city;
  Club club;
  Set<TypeActivity> typesActivity;
  

  Activity({this.id, this.title, this.description, this.date, this.quantityLeo, this.lionsParticipation, this.satisfactionDegree, this.city, this.club, this.typesActivity});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      quantityLeo: json['quantityLeo'],
      lionsParticipation: json['lionsParticipation'],
      satisfactionDegree: json['satisfactionDegree'],
      city: json['city'],
      club: json['club'],
      typesActivity: json['typesActivity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'quantityLeo': quantityLeo,
    'lionsParticipation': lionsParticipation,
    'satisfactionDegree': satisfactionDegree,
    'city': city.toJson(),
    'club': club.toJson(),
    'typesActivity': jsonEncode(typesActivity),
  };


}