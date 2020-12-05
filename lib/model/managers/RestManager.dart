import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/ErrorListener.dart';


class RestManager {
  ErrorListener delegate;
  String token;


  Future<String> _makeRequest(String serverAddress, String servicePath, String type, {Map<String, String> body, dynamic value}) async {
    Uri uri = Uri.http(serverAddress, servicePath, body);
    bool errorOccurred = false;
    while ( true ) {
      try {
        var response;
        switch (type) {
          case "post":
            response = await post(
              uri,
              headers: {
                HttpHeaders.authorizationHeader: 'bearer $token',
                HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
              },
              body: json.encode(value),
            );
            break;
          case "get":
            response = await get(
                uri,
                headers: {
                  HttpHeaders.authorizationHeader: 'bearer $token',
                  HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
                }
            );
            break;
          case "put":
            response = await put(
              uri,
              headers: {
                HttpHeaders.authorizationHeader: 'bearer $token',
                HttpHeaders.contentTypeHeader: "application/json;charset=utf-8",
              },
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

  Future<String> makeGetRequest(String serverAddress, String servicePath, [Map<String, String> body]) async {
    return _makeRequest(serverAddress, servicePath, "get", body: body);
  }

  Future<String> makePostRequest(String serverAddress, String servicePath, dynamic value) async {
    return _makeRequest(serverAddress, servicePath, "post", value: value);
  }

  Future<String> makePutRequest(String serverAddress, String servicePath, Map<String, String> body) async {
    return _makeRequest(serverAddress, servicePath, "get", body: body); // this should be put but doesn't work with flutter web actually
  }


}
