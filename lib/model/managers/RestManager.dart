import 'dart:convert';
import 'dart:io';
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
import 'package:http/http.dart';


class RestManager {


  Future<Club> makeClubRequest(String url, int id) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, {"id": id.toString()});
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return Club.fromJson(jsonDecode(response.body));
  }

  Future<Quantity> makeQuantityRequest(String url, int clubId) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, {"clubId": clubId.toString()});
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return Quantity.fromJson(jsonDecode(response.body));
  }

  Future<List<Service>> makeListServiceRequest(String url, Map<String, String> params) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, params);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<Service>.from(json.decode(response.body).map((i) => Service.fromJson(i)).toList());
  }

  Future<List<Activity>> makeListActivityRequest(String url, Map<String, String> params) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, params);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<Activity>.from(json.decode(response.body).map((i) => Activity.fromJson(i)).toList());
  }

  Future<List<District>> makeListDistrictsRequest(String url) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<District>.from(json.decode(response.body).map((i) => District.fromJson(i)).toList());
  }

  Future<List<TypeService>> makeListTypeServiceRequest(String url) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<TypeService>.from(json.decode(response.body).map((i) => TypeService.fromJson(i)).toList());
  }

  Future<List<SatisfactionDegree>> makeListSatisfactionDegreesRequest(String url) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<SatisfactionDegree>.from(json.decode(response.body).map((i) => SatisfactionDegree.fromJson(i)).toList());
  }

  Future<List<TypeActivity>> makeListTypeActivityRequest(String url) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<TypeActivity>.from(json.decode(response.body).map((i) => TypeActivity.fromJson(i)).toList());
  }

  Future<List<CompetenceArea>> makeListAreasRequest(String url) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<CompetenceArea>.from(json.decode(response.body).map((i) => CompetenceArea.fromJson(i)).toList());
  }

  Future<List<Club>> makeListClubsRequest(String url) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<Club>.from(json.decode(response.body).map((i) => Club.fromJson(i)).toList());
  }

  Future<List<City>> makeListCityRequest(String url, String name) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, {"name": name});
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return List<City>.from(json.decode(response.body).map((i) => City.fromJson(i)).toList());
  }

  Future<Service> addService(String url, Service service) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await post(
      uri,
      headers: {
        //HttpHeaders.authorizationHeader: 'Token $token',
        HttpHeaders.contentTypeHeader: 'application/json;charset=utf-8',
      },
      body: json.encode(service),
    );
    return Service.fromJson(json.decode(response.body));
  }


}