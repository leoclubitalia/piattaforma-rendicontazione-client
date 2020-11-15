import 'dart:convert';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/DateFormatter.dart';


class Service {
  int id;
  String title;
  String description;
  DateTime date;
  int quantityParticipants;
  int duration;
  String otherAssociations;
  double moneyRaised;
  int quantityServedPeople;
  City city;
  Club club;
  SatisfactionDegree satisfactionDegree;
  List<TypeService> typesService;
  List<CompetenceArea> competenceAreasService;


  Service({this.id, this.title, this.description, this.date, this.quantityParticipants, this.duration, this.otherAssociations, this.moneyRaised, this.quantityServedPeople, this.city, this.club, this.satisfactionDegree, this.typesService, this.competenceAreasService});

  Service.newCreation() {
    date = DateTime.now();
    typesService = List();
    competenceAreasService = List();
  }

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
    'id': id.toString(),
    'title': title,
    'description': description,
    'date': date.toStringUnslashed(),
    'quantityParticipants': quantityParticipants.toString(),
    'satisfactionDegree': satisfactionDegree.toJson(),
    'duration': duration.toString(),
    'otherAssociations': otherAssociations,
    'moneyRaised': moneyRaised.toString(),
    'quantityServedPeople': quantityServedPeople.toString(),
    'city': city.toJson(),
    'club': club.toJson(),
    'typesService': jsonEncode(typesService.map((e) => e.toJson()).toList()),
    'competenceAreasService': jsonEncode(competenceAreasService.map((e) => e.toJson()).toList()),
  };


}
