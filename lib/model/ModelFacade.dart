import 'dart:io';

import 'package:RendicontationPlatformLeo_Client/UI/behaviors/AppLocalizations.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/StateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
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
    List<String> _impactValues = ["all", "limited", "moderated", "elevated"];
    appState.addValue(Constants.STATE_ALL_IMPACT_VALUES, _impactValues);
  }

  void loadAllDistricts() async {
    //TODO
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
    //TODO
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
    //TODO
    List<TypeService> _types = [
      TypeService(title: "Service storico"),
      TypeService(title: "Service innovativo"),
      TypeService(title: "Service online"),
    ];
    appState.addValue(Constants.STATE_ALL_TYPE_SERVICE, _types);
  }

  void loadAllAreas() async {
    //TODO
    List<CompetenceArea> _areas = [
      CompetenceArea(title: "ambiente"),
      CompetenceArea(title: "fame"),
      CompetenceArea(title: "sport"),
    ];
    appState.addValue(Constants.STATE_ALL_AREAS, _areas);
  }

  void loadAllClubs() async {
    //TODO
    List<Club> _clubs = [
      Club(name: "Leo Club Cirò Kirimisa", city: City(name: "Cirò"), district: District(name: "ya")),
      Club(name: "Leo Club Roma Parioli", city: City(name: "Cirò"), district: District(name: "ya")),
      Club(name: "Leo Club Crotone", city: City(name: "Cirò"), district: District(name: "ya")),
    ];
    appState.addValue(Constants.STATE_ALL_CLUBS, _clubs);
  }

  Future<List<District>> suggestDistricts(String value) async {
    List<District> all = appState.getValue(Constants.STATE_ALL_DISTRICTS);
    return all.getSuggestions(value);
  }

  Future<List<City>> suggestCities(String value) async {
    List<City> all = appState.getValue(Constants.STATE_ALL_CITIES);
    return all.getSuggestions(value);
  }

  Future<List<TypeService>> suggestTypesService(String value) async {
    List<TypeService> all = appState.getValue(Constants.STATE_ALL_TYPE_SERVICE);
    return all.getSuggestions(value);
  }

  Future<List<CompetenceArea>> suggestAreas(String value) async {
    List<CompetenceArea> all = appState.getValue(Constants.STATE_ALL_AREAS);
    return all.getSuggestions(value);
  }

  Future<List<Club>> suggestClubs(String value) async {
    List<Club> all = appState.getValue(Constants.STATE_ALL_CLUBS);
    return all.getSuggestions(value);
  }

  void searchServices(String title,
                      String otherAssociations,
                      int quantityParticipants,
                      int duration,
                      int minMoneyRaised,
                      int maxMoneyRaised,
                      int quantityServedPeople,
                      District district,
                      String impactValue,
                      City city,
                      TypeService type,
                      CompetenceArea area,
                      Club club,
                      DateTime startDate,
                      DateTime endDate,
                      int page ) async {
    Map<String, String> params = Map();
    if ( title != null && title != "" ) {
      params["title"] = title;
    }
    if ( otherAssociations != null && otherAssociations != "" ) {
      params["otherAssociations"] = otherAssociations;
    }
    if ( quantityParticipants != null ) {
      params["quantityParticipants"] = quantityParticipants.toString();
    }
    if ( duration != null ) {
      params["duration"] = duration.toString();
    }
    if ( minMoneyRaised != null ) {
      params["minMoneyRaised"] = minMoneyRaised.toString();
    }
    if ( maxMoneyRaised != null ) {
      params["maxMoneyRaised"] = maxMoneyRaised.toString();
    }
    if ( quantityServedPeople != null ) {
      params["quantityServedPeople"] = quantityServedPeople.toString();
    }
    if ( district != null ) {
      params["districtId"] = district.id.toString();
    }
    if ( impactValue != null ) {
      if ( impactValue == appState.getValue(Constants.STATE_ALL_IMPACT_VALUES)[1] ) {
        params["impact"] = 1.toString();
      }
      else if ( impactValue == appState.getValue(Constants.STATE_ALL_IMPACT_VALUES)[2] ) {
        params["impact"] = 2.toString();
      }
      else if ( impactValue == appState.getValue(Constants.STATE_ALL_IMPACT_VALUES)[3] ) {
        params["impact"] = 3.toString();
      }
    }
    if ( city != null ) {
      params["cityId"] = city.id.toString();
    }
    if ( type != null ) {
      params["typeServiceId"] = type.id.toString();
    }
    if ( area != null ) {
      params["competenceAreaId"] = area.id.toString();
    }
    if ( club != null ) {
      params["clubId"] = club.id.toString();
    }
    if ( startDate != null ) {
      params["startDate"] = startDate.year.toString() + "-" + startDate.month.toString() + "-" + startDate.day.toString();
    }
    if ( endDate != null ) {
      params["endDate"] = endDate.year.toString() + "-" + endDate.month.toString() + "-" + endDate.day.toString();
    }
    if ( page != null ) {
      params["pageNumber"] = page.toString();
    }
    else {
      params["pageNumber"] = 0.toString();
    }
    params["pageSize"] = Constants.REQUEST_DEFAULT_PAGE_SIZE;
    List<Service> services = await _restManager.makeListServiceRequest(Constants.REQUEST_SEARCH_SERVICES_ADVANCED, params);
    appState.addValue(Constants.STATE_SERVICE_SEARCH_RESULT, services);
  }


}