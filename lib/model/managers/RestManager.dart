import 'dart:convert';
import 'dart:io';
import 'package:RendicontationPlatformLeo_Client/model/objects/Club.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:http/http.dart';


class RestManager {


  Future<Club> makeClubRequest(String url, Map<String, String> params) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, params);
    var response = await get(uri, headers: {
      //HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    return Club.fromJson(jsonDecode(response.body));
  }


}





