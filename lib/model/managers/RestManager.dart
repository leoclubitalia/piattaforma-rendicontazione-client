import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';


class RestManager {


  Future<String> makeGetRequest(String url, [Map<String, String> body]) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, body);
    var response = await get(
      uri,
      headers: {
        //HttpHeaders.authorizationHeader: 'Token $token',
        HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
      }
    );
    return response.body;
  }

  Future<String> makePostRequest(String url, dynamic value) async {
    Uri uri = Uri.http(Constants.BASE_URL, url);
    var response = await post(
      uri,
      headers: {
        //HttpHeaders.authorizationHeader: 'Token $token',
        HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
      },
      body: json.encode(value),
    );
    return response.body;
  }


}
