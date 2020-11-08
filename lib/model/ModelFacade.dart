import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/StateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Searcher.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/DateFormatter.dart';

class ModelFacade {
  static ModelFacade sharedInstance = ModelFacade();

  StateManager appState = StateManager();

  RestManager _restManager = RestManager();


  void loadInfoClub(String name) async {
    Club club = await _restManager.makeClubRequest(Constants.REQUEST_INFO_CLUB, name);
    Quantity quantityServices = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_SERVICES, club.id);
    club.quantityServices = quantityServices;
    Quantity quantityActivities = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_ACTIVITIES, club.id);
    club.quantityActivities = quantityActivities;
    appState.addValue(Constants.STATE_CLUB, club);
  }

  void loadAllBools() async {
    List<String> _boolValues = ["all", "yes", "no"];
    appState.addValue(Constants.STATE_ALL_BOOLS, _boolValues);
  }

  void loadAllSatisfactionDegrees() async {
    List<String> _impactValues = ["all", "limited", "moderated", "elevated"];
    appState.addValue(Constants.STATE_ALL_SATISFACTION_DEGREES, _impactValues);
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
      TypeService(title: "storico"),
      TypeService(title: "innovativo"),
      TypeService(title: "online"),
    ];
    appState.addValue(Constants.STATE_ALL_TYPE_SERVICE, _types);
  }

  void loadAllTypesActivity() async {
    //TODO
    List<TypeActivity> _types = [
      TypeActivity(title: "gemellaggio"),
      TypeActivity(title: "riunione"),
      TypeActivity(title: "formazione"),
    ];
    appState.addValue(Constants.STATE_ALL_TYPE_ACTIVITY, _types);
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
      Club(id: 1, name: "Leo Club Cirò Kirimisa", city: City(name: "Cirò"), district: District(name: "ya")),
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

  Future<List<TypeActivity>> suggestTypesActivity(String value) async {
    List<TypeActivity> all = appState.getValue(Constants.STATE_ALL_TYPE_ACTIVITY);
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
                      String satisfactionDegree,
                      City city,
                      TypeService type,
                      CompetenceArea area,
                      Club club,
                      DateTime startDate,
                      DateTime endDate,
                      int page) async {
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
    if ( satisfactionDegree != null ) {
      if ( satisfactionDegree == appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES)[1] ) {
        params["satisfactionDegree"] = 1.toString();
      }
      else if ( satisfactionDegree == appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES)[2] ) {
        params["satisfactionDegree"] = 2.toString();
      }
      else if ( satisfactionDegree == appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES)[3] ) {
        params["satisfactionDegree"] = 3.toString();
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
      params["startDate"] = startDate.toStringUnslashed();
    }
    if ( endDate != null ) {
      params["endDate"] = endDate.toStringUnslashed();
    }
    if ( page != null ) {
      params["pageNumber"] = page.toString();
    }
    else {
      params["pageNumber"] = 0.toString();
    }
    params["pageSize"] = Constants.REQUEST_DEFAULT_PAGE_SIZE;
    print(params);
    try {
      List<Service> services = await _restManager.makeListServiceRequest(Constants.REQUEST_SEARCH_SERVICES_ADVANCED, params);
      if ( page == 0 ) {
        appState.addValue(Constants.STATE_SEARCH_SERVICE_RESULT, services);
        if ( services.isEmpty ) {
          appState.addValue(Constants.STATE_MESSAGE, "no_results");
        }
      }
      else {
        appState.addValue(Constants.STATE_SEARCH_SERVICE_RESULT, appState.getValue(Constants.STATE_SEARCH_SERVICE_RESULT) + services);
      }
    }
    catch(e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
      appState.addValue(Constants.STATE_SEARCH_SERVICE_RESULT, List<Service>());
    }
  }

  void searchActivities(String title,
                        int quantityLeo,
                        District district,
                        String satisfactionDegree,
                        City city,
                        TypeActivity type,
                        Club club,
                        DateTime startDate,
                        DateTime endDate,
                        String lionsParticipations,
                        int page) async {
    Map<String, String> params = Map();
    if ( title != null && title != "" ) {
      params["title"] = title;
    }
    if ( quantityLeo != null ) {
      params["quantityLeo"] = quantityLeo.toString();
    }
    if ( district != null ) {
      params["districtId"] = district.id.toString();
    }
    if ( satisfactionDegree != null ) {
      if ( satisfactionDegree == appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES)[1] ) {
        params["satisfactionDegree"] = 1.toString();
      }
      else if ( satisfactionDegree == appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES)[2] ) {
        params["satisfactionDegree"] = 2.toString();
      }
      else if ( satisfactionDegree == appState.getValue(Constants.STATE_ALL_SATISFACTION_DEGREES)[3] ) {
        params["satisfactionDegree"] = 3.toString();
      }
    }
    if ( city != null ) {
      params["cityId"] = city.id.toString();
    }
    if ( type != null ) {
      params["typeActivityId"] = type.id.toString();
    }
    if ( club != null ) {
      params["clubId"] = club.id.toString();
    }
    if ( startDate != null ) {
      params["startDate"] = startDate.toStringUnslashed();
    }
    if ( endDate != null ) {
      params["endDate"] = endDate.toStringUnslashed();
    }
    if ( lionsParticipations != null ) {
      if ( lionsParticipations == appState.getValue(Constants.STATE_ALL_BOOLS)[1] ) {
        params["lionsParticipations"] = 1.toString();
      }
      else if ( lionsParticipations == appState.getValue(Constants.STATE_ALL_BOOLS)[2] ) {
        params["lionsParticipations"] = 2.toString();
      }
    }
    if ( page != null ) {
      params["pageNumber"] = page.toString();
    }
    else {
      params["pageNumber"] = 0.toString();
    }
    params["pageSize"] = Constants.REQUEST_DEFAULT_PAGE_SIZE;
    print(params);
    try {
      List<Activity> activities = await _restManager.makeListActivityRequest(Constants.REQUEST_SEARCH_ACTIVITIES_ADVANCED, params);
      if ( page == 0 ) {
        appState.addValue(Constants.STATE_SEARCH_ACTIVITY_RESULT, activities);
        if ( activities.isEmpty ) {
          appState.addValue(Constants.STATE_MESSAGE, "no_results");
        }
      }
      else {
        appState.addValue(Constants.STATE_SEARCH_ACTIVITY_RESULT, appState.getValue(Constants.STATE_SEARCH_ACTIVITY_RESULT) + activities);
      }
    }
    catch(e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
      appState.addValue(Constants.STATE_SEARCH_ACTIVITY_RESULT, List<Activity>());
    }
  }


}