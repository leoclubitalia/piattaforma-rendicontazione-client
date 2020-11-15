import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/StateManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/City.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/CompetenceArea.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/District.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/SatisfacionDegree.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeActivity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/TypeService.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/Searcher.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';


class ModelFacade {
  static ModelFacade sharedInstance = ModelFacade();

  StateManager appState = StateManager();

  RestManager _restManager = RestManager();

  int currentClubId = 1; //TODO temp


  void loadInfoCurrentClub() {
    _loadInfoClub(currentClubId);
  }

  void _loadInfoClub(int id) async {
    if ( !appState.existsValue(Constants.STATE_CLUB) ) {
      Club club = await _restManager.makeClubRequest(Constants.REQUEST_INFO_CLUB, id);
      Quantity quantityServices = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_SERVICES, club.id);
      club.quantityServices = quantityServices;
      Quantity quantityActivities = await _restManager.makeQuantityRequest(Constants.REQUEST_CLUB_QUANTITY_ACTIVITIES, club.id);
      club.quantityActivities = quantityActivities;
      appState.addValue(Constants.STATE_CLUB, club);
    }
  }

  void loadAllBools() async {
    if ( !appState.existsValue(Constants.STATE_ALL_BOOLS) ) {
      List<String> boolValues = ["all", "yes", "no"];
      appState.addValue(Constants.STATE_ALL_BOOLS, boolValues);
    }
  }

  void loadAllSatisfactionDegrees() async {
    if ( !appState.existsValue(Constants.STATE_ALL_SATISFACTION_DEGREES) ) {
      List<SatisfactionDegree> satisfactionDegrees = await _restManager.makeListSatisfactionDegreesRequest(Constants.REQUEST_SEARCH_ALL_SATISFACTION_DEGREES);
      appState.addValue(Constants.STATE_ALL_SATISFACTION_DEGREES, satisfactionDegrees);
    }
  }

  void loadAllDistricts() async {
    if ( !appState.existsValue(Constants.STATE_ALL_DISTRICTS) ) {
      List<District> districts = await _restManager.makeListDistrictsRequest(Constants.REQUEST_SEARCH_ALL_DISTRICTS);
      appState.addValue(Constants.STATE_ALL_DISTRICTS, districts);
    }
  }

  void loadAllTypesService() async {
    if ( !appState.existsValue(Constants.STATE_ALL_TYPE_SERVICE) ) {
      List<TypeService> types = await _restManager.makeListTypeServiceRequest(Constants.REQUEST_SEARCH_ALL_TYPES_SERVICE);
      appState.addValue(Constants.STATE_ALL_TYPE_SERVICE, types);
    }
  }

  void loadAllTypesActivity() async {
    if ( !appState.existsValue(Constants.STATE_ALL_TYPE_ACTIVITY) ) {
      List<TypeActivity> types = await _restManager.makeListTypeActivityRequest(Constants.REQUEST_SEARCH_ALL_TYPES_ACTIVITY);
      appState.addValue(Constants.STATE_ALL_TYPE_ACTIVITY, types);
    }
  }

  void loadAllAreas() async {
    if ( !appState.existsValue(Constants.STATE_ALL_AREAS) ) {
      List<CompetenceArea> types = await _restManager.makeListAreasRequest(Constants.REQUEST_SEARCH_ALL_AREAS);
      appState.addValue(Constants.STATE_ALL_AREAS, types);
    }
  }

  void loadAllClubs() async {
    if ( !appState.existsValue(Constants.STATE_ALL_CLUBS) ) {
      List<Club> types = await _restManager.makeListClubsRequest(Constants.REQUEST_SEARCH_ALL_CLUBS);
      appState.addValue(Constants.STATE_ALL_CLUBS, types);
    }
  }

  Future<List<District>> suggestDistricts(String value) async {
    List<District> all = appState.getValue(Constants.STATE_ALL_DISTRICTS);
    return all.getSuggestions(value);
  }

  Future<List<City>> suggestCities(String value) async {
    if ( value != null && value.replaceAll(" ", "") != "" ) {
      return await _restManager.makeListCityRequest(Constants.REQUEST_SEARCH_CITIES, value);
    }
    return List<City>();
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
                      SatisfactionDegree satisfactionDegree,
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
      params["satisfactionDegree"] = satisfactionDegree.id.toString();
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
    catch (e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
      appState.addValue(Constants.STATE_SEARCH_SERVICE_RESULT, List<Service>());
    }
  }

  void searchActivities(String title,
                        int quantityLeo,
                        District district,
                        SatisfactionDegree satisfactionDegree,
                        City city,
                        TypeActivity type,
                        Club club,
                        DateTime startDate,
                        DateTime endDate,
                        String lionsParticipation,
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
      params["satisfactionDegree"] = satisfactionDegree.id.toString();
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
    if ( lionsParticipation != null ) {
      if ( lionsParticipation == appState.getValue(Constants.STATE_ALL_BOOLS)[1] ) {
        params["lionsParticipation"] = 1.toString();
      }
      else if ( lionsParticipation == appState.getValue(Constants.STATE_ALL_BOOLS)[2] ) {
        params["lionsParticipation"] = 0.toString();
      }
    }
    if ( page != null ) {
      params["pageNumber"] = page.toString();
    }
    else {
      params["pageNumber"] = 0.toString();
    }
    params["pageSize"] = Constants.REQUEST_DEFAULT_PAGE_SIZE;
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
    catch (e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
      appState.addValue(Constants.STATE_SEARCH_ACTIVITY_RESULT, List<Activity>());
    }
  }

  void addService(Service service) async {
    service.club = Club(id: currentClubId);
    try {
      service = await _restManager.addService(Constants.REQUEST_ADD_SERVICE, service);
      appState.addValue(Constants.STATE_JUST_ADDED_SERVICE, service);
    }
    catch (e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
    }
  }


}