import 'dart:convert';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';


class Service {
  int id;
  String title;
  String description;
  DateTime date;
  int quantityParticipants;
  int satisfactionDegree;
  int impact; //***
  int duration;
  String otherAssociations; //***
  double moneyRaised;
  int quantityServedPeople;
  City city;
  Club club;
  List<TypeService> typesService; //***
  List<CompetenceArea> competenceAreasService;


  Service({this.id, this.title, this.description, this.date, this.quantityParticipants, this.satisfactionDegree, this.impact, this.duration, this.otherAssociations, this.moneyRaised, this.quantityServedPeople, this.city, this.club, this.typesService, this.competenceAreasService});

  factory Service.fromJson(Map<String, dynamic> json) {
    List<TypeService> typesService = List();
    for ( Map<String, dynamic> rawTypeService in json['typesService'] ) {
      typesService.add(TypeService.fromJson(rawTypeService));
    }
    List<CompetenceArea> competenceAreasService = List();
    for ( Map<String, dynamic> rawCompetenceArea in json['competenceAreasService'] ) {
      competenceAreasService.add(CompetenceArea.fromJson(rawCompetenceArea));
    }
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.fromMillisecondsSinceEpoch(json['date']),
      quantityParticipants: json['quantityParticipants'],
      satisfactionDegree: json['satisfactionDegree'],
      impact: json['impact'],
      duration: json['duration'],
      otherAssociations: json['otherAssociations'],
      moneyRaised: json['moneyRaised'],
      quantityServedPeople: json['quantityServedPeople'],
      city: City.fromJson(json['city']),
      club: Club.fromJson(json['club']),
      typesService: typesService,
      competenceAreasService: competenceAreasService,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date,
    'quantityParticipants': quantityParticipants,
    'satisfactionDegree': satisfactionDegree,
    'impact': impact,
    'duration': duration,
    'otherAssociations': otherAssociations,
    'moneyRaised': moneyRaised,
    'quantityServedPeople': quantityServedPeople,
    'city': city.toJson(),
    'club': club.toJson(),
    'typesService': jsonEncode(typesService),
    'competenceAreasService': jsonEncode(competenceAreasService),
  };


}