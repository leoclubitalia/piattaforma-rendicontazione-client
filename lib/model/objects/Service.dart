import 'dart:convert';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';


class Service {
  int id;
  String title;
  String description;
  DateTime date = DateTime.now();
  int quantityParticipants;
  int impact;
  int duration;
  String otherAssociations;
  double moneyRaised;
  int quantityServedPeople;
  City city;
  Club club;
  SatisfactionDegree satisfactionDegree;
  List<TypeService> typesService = List();
  List<CompetenceArea> competenceAreasService = List();


  Service({this.id, this.title, this.description, this.date, this.quantityParticipants, this.impact, this.duration, this.otherAssociations, this.moneyRaised, this.quantityServedPeople, this.city, this.club, this.satisfactionDegree, this.typesService, this.competenceAreasService});

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
      satisfactionDegree: SatisfactionDegree.fromJson(json['satisfactionDegree']),
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
    'satisfactionDegree': satisfactionDegree.toJson(),
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