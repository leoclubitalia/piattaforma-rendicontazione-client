import 'dart:io';

import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/StateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Searcher.dart';


class ModelFacade {
  static ModelFacade sharedInstance = new ModelFacade();

  StateManager appState = new StateManager();

  RestManager _restManager = new RestManager();


  void loadInfoClub(String name) async {
    Club club = await _restManager.makeClubRequest(Constants.REQUEST_INFO_CLUB, name);
    Quantity quantityServices = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_SERVICES, club.id);
    club.quantityServices = quantityServices;
    Quantity quantityActivities = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_ACTIVITIES, club.id);
    club.quantityActivities = quantityActivities;
    appState.addValue(Constants.STATE_CLUB, club);
  }

  void loadAllImpactValues() async {
    List<String> _impactValues = [
      "all",
      "limited",
      "moderated",
      "elevated",
    ];
    appState.addValue(Constants.STATE_ALL_IMPACT_VALUES, _impactValues);
  }

  void loadAllDistricts() async {
    List<District> _districts = [
      District(id: 1, name: "ya"),
      District(id: 2, name: "yb"),
      District(id: 3, name: "ia1"),
      District(id: 4, name: "ia2"),
      District(id: 5, name: "tb"),
    ];
    appState.addValue(Constants.STATE_ALL_DISTRICTS, _districts);
  }

  void loadAllCities() async {
    print("loadAllCities");
    List<City> _cities = [
      City(name: "Cirò"),
      City(name: "Roma"),
      City(name: "Caccuri"),
      City(name: "Palemmo"),
    ];
    //sleep(const Duration(seconds:1));
    print("loadAllCities2");
    Future.delayed(const Duration(seconds: 1), () => {
      appState.addValue(Constants.STATE_ALL_CITIES, _cities)
    });


  }

  void loadAllTypesService() async {
    List<TypeService> _types = [
      TypeService(title: "Service storico"),
      TypeService(title: "Service innovativo"),
      TypeService(title: "Service online"),
    ];
    appState.addValue(Constants.STATE_ALL_TYPE_SERVICE, _types);
  }

  void loadAllAreas() async {
    List<CompetenceArea> _areas = [
      CompetenceArea(title: "ambiente"),
      CompetenceArea(title: "fame"),
      CompetenceArea(title: "sport"),
    ];
    appState.addValue(Constants.STATE_ALL_AREAS, _areas);
  }

  void loadAllClubs() async {
    List<Club> _clubs = [
      Club(name: "Leo Club Cirò Kirimisa", city: City(name: "Cirò"), district: District(name: "ya")),
      Club(name: "Leo Club Roma Parioli", city: City(name: "Cirò"), district: District(name: "ya")),
      Club(name: "Leo Club Crotone", city: City(name: "Cirò"), district: District(name: "ya")),
    ];
    appState.addValue(Constants.STATE_ALL_CLUBS, _clubs);
  }

  Future<List<District>> suggestDistrict(String value) async {
    List<District> all = appState.getValue(Constants.STATE_ALL_DISTRICTS);
    return all.getSuggestions(value);
  }

  Future<List<City>> suggestCity(String value) async {
    List<City> all = appState.getValue(Constants.STATE_ALL_CITIES);
    return all.getSuggestions(value);
  }

  Future<List<TypeService>> suggestTypeService(String value) async {
    List<TypeService> all = appState.getValue(Constants.STATE_ALL_TYPE_SERVICE);
    return all.getSuggestions(value);
  }

  Future<List<CompetenceArea>> suggestArea(String value) async {
    List<CompetenceArea> all = appState.getValue(Constants.STATE_ALL_AREAS);
    return all.getSuggestions(value);
  }

  Future<List<Club>> suggestClub(String value) async {
    List<Club> all = appState.getValue(Constants.STATE_ALL_CLUBS);
    return all.getSuggestions(value);
  }


}