import 'dart:convert';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/AuthenticationData.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';


class ParsingManager {


  AuthenticationData parseAuthenticationData(String value) {
    return AuthenticationData.fromJson(jsonDecode(value));
  }

  Club parseClub(String value) {
    return Club.fromJson(jsonDecode(value));
  }

  Quantity parseQuantity(String value) {
    return Quantity.fromJson(jsonDecode(value));
  }

  List<Service> parseServices(String value) {
    return List<Service>.from(json.decode(value).map((i) => Service.fromJson(i)).toList());
  }

  Service parseService(String value) {
    return Service.fromJson(json.decode(value));
  }

  List<Activity> parseActivities(String value) {
    return List<Activity>.from(json.decode(value).map((i) => Activity.fromJson(i)).toList());
  }

  Activity parseActivity(String value) {
    return Activity.fromJson(json.decode(value));
  }

  List<District> parseDistricts(String value) {
    return List<District>.from(json.decode(value).map((i) => District.fromJson(i)).toList());
  }

  List<TypeService> parseTypeServices(String value) {
    return List<TypeService>.from(json.decode(value).map((i) => TypeService.fromJson(i)).toList());
  }

  List<TypeActivity> parseTypeActivities(String value) {
    return List<TypeActivity>.from(json.decode(value).map((i) => TypeActivity.fromJson(i)).toList());
  }

  List<SatisfactionDegree> parseSatisfactionDegrees(String value) {
    return List<SatisfactionDegree>.from(json.decode(value).map((i) => SatisfactionDegree.fromJson(i)).toList());
  }

  List<CompetenceArea> parseCompetenceAreas(String value) {
    return List<CompetenceArea>.from(json.decode(value).map((i) => CompetenceArea.fromJson(i)).toList());
  }

  List<Club> parseClubs(String value) {
    return List<Club>.from(json.decode(value).map((i) => Club.fromJson(i)).toList());
  }

  List<City> parseCities(String value) {
    return List<City>.from(json.decode(value).map((i) => City.fromJson(i)).toList());
  }


}