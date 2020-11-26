import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/ErrorListener.dart';



class RestManager {
  ErrorListener delegate;


  Future<String> _makeRequest(String url, String type, {Map<String, String> body, dynamic value}) async {
    Uri uri = Uri.http(Constants.BASE_URL, url, body);
    bool errorOccurred = false;
    while ( true ) {
      try {
        var response;
        switch (type) {
          case "post":
            response = await post(
              uri,
              headers: {
                //HttpHeaders.authorizationHeader: 'Token $token',
                HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
              },
              body: json.encode(value),
            );
            break;
          case "get":
            response = await get(
                uri,
                headers: {
                  //HttpHeaders.authorizationHeader: 'Token $token',
                  HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
                }
            );
            break;
          case "put":
            response = await put(
              uri,
              headers: {
                //HttpHeaders.authorizationHeader: 'Token $token',
                HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
              },
              body: json.encode(value),
            );
            break;
        }
        if ( delegate != null && errorOccurred ) {
          delegate.errorNetworkGone();
          errorOccurred = false;
        }
        return response.body;
      } catch(e) {
        if ( delegate != null && !errorOccurred ) {
          delegate.errorNetworkOccurred(Constants.MESSAGE_CONNECTION_ERROR);
          errorOccurred = true;
        }
        await Future.delayed(const Duration(seconds: 3), () => null);
      }
    }
  }

  Future<String> makeGetRequest(String url, [Map<String, String> body]) async {
    return _makeRequest(url, "get", body: body);
  }

  Future<String> makePostRequest(String url, dynamic value) async {
    return _makeRequest(url, "post", value: value);
  }

  Future<String> makePutRequest(String url, dynamic value) async {
    return _makeRequest(url, "put", value: value);
  }


}
