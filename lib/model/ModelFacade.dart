import 'dart:async';
import 'package:RendicontationPlatformLeo_Client/model/managers/ParsingManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/RestManager.dart';
import 'package:RendicontationPlatformLeo_Client/model/managers/StateManager.dart';
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
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/ErrorListener.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/Suggester.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/extensions/DateFormatter.dart';


class ModelFacade implements ErrorListener {
  static ModelFacade sharedInstance = ModelFacade();

  ErrorListener delegate;
  StateManager appState = StateManager();

  RestManager _restManager = RestManager();
  ParsingManager _parsingManager = ParsingManager();
  AuthenticationData _authenticationData;
  Club _currentClub;


  ModelFacade() {
    _restManager.delegate = this;
  }

  @override
  void errorNetworkGone() {
    if ( delegate != null ) {
      delegate.errorNetworkGone();
    }
  }

  @override
  void errorNetworkOccurred(String message) {
    if ( delegate != null ) {
      delegate.errorNetworkOccurred(message);
    }
  }

  Future<bool> login(String email, String password) async {
    try{
      Map<String, String> params = Map();
      params["grant_type"] = "password";
      params["client_id"] = Constants.CLIENT_ID;
      params["client_secret"] = Constants.CLIENT_SECRET;
      params["username"] = email;
      params["password"] = password;
      String result = await _restManager.makePostRequest(Constants.SERVER_ADDRESS_AUTHENTICATION, Constants.REQUEST_TOKEN_AUTHENTICATION, params, type: TypeHeader.urlencoded);
      _authenticationData = _parsingManager.parseAuthenticationData(result);
      _restManager.token = _authenticationData.accessToken;
      _loadInfoClub(email);
      Timer.periodic(Duration(seconds: (_authenticationData.expiresIn - 50)), (Timer t) async {
        Map<String, String> params = Map();
        params["grant_type"] = "refresh_token";
        params["client_id"] = Constants.CLIENT_ID;
        params["refresh_token"] = _authenticationData.refreshToken;
        String result = await _restManager.makePostRequest(Constants.SERVER_ADDRESS_AUTHENTICATION, Constants.REQUEST_TOKEN_AUTHENTICATION, params, type: TypeHeader.urlencoded);
        _authenticationData = _parsingManager.parseAuthenticationData(result);
        _restManager.token = _authenticationData.accessToken;
      });
      return true;
    }
    catch (e) {
      return false;
    }
  }

  void _loadInfoClub(String email) async {
    if ( !appState.existsValue(Constants.STATE_CLUB) ) {
      _currentClub = _parsingManager.parseClub(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_INFO_CLUB));
      Quantity quantityServices = _parsingManager.parseQuantity(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_CLUB_QUANTITY_SERVICES, {"clubId": _currentClub.id.toString()}));
      _currentClub.quantityServices = quantityServices;
      Quantity quantityActivities = _parsingManager.parseQuantity(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_CLUB_QUANTITY_ACTIVITIES, {"clubId": _currentClub.id.toString()}));
      _currentClub.quantityActivities = quantityActivities;
      appState.addValue(Constants.STATE_CLUB, _currentClub);
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
      List<SatisfactionDegree> satisfactionDegrees = _parsingManager.parseSatisfactionDegrees(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ALL_SATISFACTION_DEGREES));
      appState.addValue(Constants.STATE_ALL_SATISFACTION_DEGREES, satisfactionDegrees);
    }
  }

  void loadAllDistricts() async {
    if ( !appState.existsValue(Constants.STATE_ALL_DISTRICTS) ) {
      List<District> districts = _parsingManager.parseDistricts(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ALL_DISTRICTS));
      appState.addValue(Constants.STATE_ALL_DISTRICTS, districts);
    }
  }

  void loadAllTypesService() async {
    if ( !appState.existsValue(Constants.STATE_ALL_TYPE_SERVICE) ) {
      List<TypeService> types = _parsingManager.parseTypeServices(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ALL_TYPES_SERVICE));
      appState.addValue(Constants.STATE_ALL_TYPE_SERVICE, types);
    }
  }

  void loadAllTypesActivity() async {
    if ( !appState.existsValue(Constants.STATE_ALL_TYPE_ACTIVITY) ) {
      List<TypeActivity> types = _parsingManager.parseTypeActivities(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ALL_TYPES_ACTIVITY));
      appState.addValue(Constants.STATE_ALL_TYPE_ACTIVITY, types);
    }
  }

  void loadAllAreas() async {
    if ( !appState.existsValue(Constants.STATE_ALL_AREAS) ) {
      List<CompetenceArea> areas = _parsingManager.parseCompetenceAreas(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ALL_AREAS));
      appState.addValue(Constants.STATE_ALL_AREAS, areas);
    }
  }

  void loadAllClubs() async {
    if ( !appState.existsValue(Constants.STATE_ALL_CLUBS) ) {
      List<Club> clubs = _parsingManager.parseClubs(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ALL_CLUBS));
      appState.addValue(Constants.STATE_ALL_CLUBS, clubs);
    }
  }

  Future<List<District>> suggestDistricts(String value) async {
    List<District> all = appState.getValue(Constants.STATE_ALL_DISTRICTS);
    return all.getSuggestions(value);
  }

  Future<List<City>> suggestCities(String value) async {
    if ( value != null && value.replaceAll(" ", "") != "" ) {
      return _parsingManager.parseCities(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_CITIES, {"name": value}));
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

  void updateQuantityMembers(String value) async {
    Map<String, String> params = Map();
    params["clubId"] = _currentClub.id.toString();
    params["newQuantity"] = value;
    _restManager.makePutRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_UPDATE_QUANTITY_MEMBERS, params);
  }

  void updateQuantityAspirants(String value) async {
    Map<String, String> params = Map();
    params["clubId"] = _currentClub.id.toString();
    params["newQuantity"] = value;
    _restManager.makePutRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_UPDATE_QUANTITY_ASPIRANTS, params);
  }

  void searchServices(String title,
                      String otherAssociations,
                      int quantityParticipants,
                      int duration,
                      String moneyOrMaterialCollected,
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
    if ( moneyOrMaterialCollected != null ) {
      params["moneyOrMaterialCollected"] = moneyOrMaterialCollected;
    }
    if ( quantityServedPeople != null ) {
      params["quantityServedPeople"] = quantityServedPeople.toString();
    }
    if ( district != null ) {
      params["districtId"] = district.id.toString();
    }
    if ( satisfactionDegree != null && satisfactionDegree.id != null ) {
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
      List<Service> services = _parsingManager.parseServices(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_SERVICES_ADVANCED, params));
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
    if ( satisfactionDegree != null && satisfactionDegree.id != null ) {
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
      List<Activity> activities = _parsingManager.parseActivities(await _restManager.makeGetRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_SEARCH_ACTIVITIES_ADVANCED, params));
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
    service.club = _currentClub;
    try {
      service = _parsingManager.parseService(await _restManager.makePostRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_ADD_SERVICE, service));
      Club club = appState.getValue(Constants.STATE_CLUB);
      club.quantityServices.currentYear ++;
      club.quantityServices.all ++;
      appState.updateValue(Constants.STATE_CLUB, club);
      appState.addValue(Constants.STATE_JUST_ADDED_SERVICE, service);
      List<Service> services = appState.getAndDestroyValue(Constants.STATE_SEARCH_SERVICE_RESULT);
      services.insert(0, service);
      appState.addValue(Constants.STATE_SEARCH_SERVICE_RESULT, services);
    }
    catch (e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
    }
  }

  void addActivity(Activity activity) async {
    activity.club = _currentClub;
    try {
      activity = _parsingManager.parseActivity(await _restManager.makePostRequest(Constants.SERVER_ADDRESS_MAIN, Constants.REQUEST_ADD_ACTIVITY, activity));
      appState.addValue(Constants.STATE_JUST_ADDED_ACTIVITY, activity);
      Club club = appState.getValue(Constants.STATE_CLUB);
      club.quantityActivities.currentYear ++;
      club.quantityActivities.all ++;
      appState.updateValue(Constants.STATE_CLUB, club);
      appState.addValue(Constants.STATE_JUST_ADDED_SERVICE, activity);
      List<Activity> activities = appState.getAndDestroyValue(Constants.STATE_SEARCH_ACTIVITY_RESULT);
      activities.insert(0, activity);
      appState.addValue(Constants.STATE_SEARCH_ACTIVITY_RESULT, activities);
    }
    catch (e) {
      appState.addValue(Constants.STATE_MESSAGE, "message_error");
    }
  }


}
