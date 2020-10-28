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
  int impact;
  int duration;
  String otherAssociations;
  double moneyRaised;
  int quantityServedPeople;
  City city;
  Club club;
  Set<TypeService> typesService;
  Set<CompetenceArea> competenceAreasService;


  Service({this.id, this.title, this.description, this.date, this.quantityParticipants, this.satisfactionDegree, this.impact, this.duration, this.otherAssociations, this.moneyRaised, this.quantityServedPeople, this.city, this.club, this.typesService, this.competenceAreasService});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      quantityParticipants: json['quantityParticipants'],
      satisfactionDegree: json['satisfactionDegree'],
      impact: json['impact'],
      duration: json['duration'],
      otherAssociations: json['otherAssociations'],
      moneyRaised: json['moneyRaised'],
      quantityServedPeople: json['quantityServedPeople'],
      city: json['city'],
      club: json['club'],
      typesService: json['typesService'],
      competenceAreasService: json['competenceAreasService'],
    );
  }


}