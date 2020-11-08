import 'dart:convert';
import 'dart:io';
import 'package:RendicontationPlatformLeo_Client/model/objects/Activity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Quantity.dart';
import 'package:RendicontationPlatformLeo_Client/model/objects/Service.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:http/http.dart';


class RestManager {


  Future<Club> makeClubRequest(String url, String name) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, {"name": name});
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return Club.fromJson(jsonDecode(response.body));
  }

  Future<Quantity> makeQuantityRequest(String url, int clubId) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, {"club_id": clubId.toString()});
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
    print(response.body);
    return List<Service>.from(json.decode(response.body).map((i) => Service.fromJson(i)).toList());
  }

  Future<List<Activity>> makeListActivityRequest(String url, Map<String, String> params) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, params);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    print(response.body);
    return List<Activity>.from(json.decode(response.body).map((i) => Activity.fromJson(i)).toList());
  }


}