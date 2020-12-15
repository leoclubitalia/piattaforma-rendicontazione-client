class Constants {
  static final String SERVER_ADDRESS_MAIN = "rendicontazione.leoclub.it:2096";
  static final String SERVER_ADDRESS_AUTHENTICATION = "rendicontazione.leoclub.it:8443";
  static final String REQUEST_DEFAULT_PAGE_SIZE = "30";

  static final String CLIENT_ID = "rendicontation-flutter";
  static final String CLIENT_SECRET = "8134ee44-0322-4fde-adff-f47e58376c86";
  static final String REQUEST_TOKEN_AUTHENTICATION = "/auth/realms/rendicontation/protocol/openid-connect/token";

  static final String REQUEST_INFO_CLUB = "/club/details";
  static final String REQUEST_CLUB_QUANTITY_SERVICES = "/club/quantity_services_made";
  static final String REQUEST_CLUB_QUANTITY_ACTIVITIES = "/club/quantity_activities_made";
  static final String REQUEST_UPDATE_QUANTITY_MEMBERS = "/club/update/quantity_current_members";
  static final String REQUEST_UPDATE_QUANTITY_ASPIRANTS = "/club/update/quantity_aspirant_members";
  static final String REQUEST_SEARCH_SERVICES_ADVANCED = "/search/service/advanced";
  static final String REQUEST_SEARCH_ACTIVITIES_ADVANCED = "/search/activity/advanced";
  static final String REQUEST_SEARCH_CITIES = "/search/city/by_name";
  static final String REQUEST_SEARCH_ALL_DISTRICTS = "/search/district/all";
  static final String REQUEST_SEARCH_ALL_TYPES_SERVICE = "/search/type/service/all";
  static final String REQUEST_SEARCH_ALL_TYPES_ACTIVITY = "/search/type/activity/all";
  static final String REQUEST_SEARCH_ALL_AREAS = "/search/competence_area/all";
  static final String REQUEST_SEARCH_ALL_CLUBS = "/search/club/all";
  static final String REQUEST_SEARCH_ALL_SATISFACTION_DEGREES = "/search/satisfaction_degree/all";
  static final String REQUEST_ADD_SERVICE = "/services";
  static final String REQUEST_ADD_ACTIVITY = "/activities";

  static final String STATE_CLUB = "club";
  static final String STATE_ALL_SATISFACTION_DEGREES = "all_satisfaction_degrees";
  static final String STATE_ALL_DISTRICTS = "all_districts";
  static final String STATE_ALL_TYPE_SERVICE = "all_type_service";
  static final String STATE_ALL_TYPE_ACTIVITY = "all_type_activity";
  static final String STATE_ALL_AREAS = "all_areas";
  static final String STATE_ALL_CLUBS = "all_club";
  static final String STATE_ALL_BOOLS = "all_bools";
  static final String STATE_SEARCH_SERVICE_RESULT = "search_result_service";
  static final String STATE_SEARCH_ACTIVITY_RESULT = "search_result_activity";
  static final String STATE_MESSAGE = "message";
  static final String STATE_JUST_ADDED_SERVICE = "just_added_service";
  static final String STATE_JUST_ADDED_ACTIVITY = "just_added_activity";
  static final String STATE_JUST_ADDED = "just_added";

  static final String MESSAGE_CONNECTION_ERROR = "connection_error";


}