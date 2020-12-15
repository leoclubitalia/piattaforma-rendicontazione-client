import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/ErrorListener.dart';


enum TypeHeader {
  json,
  urlencoded
}


class RestManager {
  ErrorListener delegate;
  String token;


  Future<String> _makeRequest(String serverAddress, String servicePath, String method, TypeHeader type, {Map<String, String> value, dynamic body}) async {
    Uri uri = Uri.https(serverAddress, servicePath, value);
    print(uri);
    bool errorOccurred = false;
    while ( true ) {
      try {
        var response;
        switch ( method ) {
          case "post":
            String contentType;
            dynamic formattedBody;
            if ( type == TypeHeader.json ) {
              contentType = "application/json;charset=utf-8";
              formattedBody = json.encode(body);
            }
            else if ( type == TypeHeader.urlencoded ) {
              contentType = "application/x-www-form-urlencoded";
              formattedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
            }
            response = await post(
              uri,
              headers: {
                HttpHeaders.authorizationHeader: 'bearer $token',
                HttpHeaders.contentTypeHeader: contentType,
              },
              body: formattedBody,
            );
            break;
          case "get":
            response = await get(
              uri,
              headers: {
                HttpHeaders.authorizationHeader: 'bearer $token',
                HttpHeaders.contentTypeHeader: "application/json;charset=unicode",
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
        print(response.body);
        return response.body;
      } catch(err, stacktrace) {
        if ( delegate != null && !errorOccurred ) {
          delegate.errorNetworkOccurred(Constants.MESSAGE_CONNECTION_ERROR);
          errorOccurred = true;
        }
        await Future.delayed(const Duration(seconds: 5), () => null);
      }
    }
  }

  Future<String> makePostRequest(String serverAddress, String servicePath, dynamic value, {TypeHeader type = TypeHeader.json}) async {
    return _makeRequest(serverAddress, servicePath, "post", type, body: value);
  }

  Future<String> makeGetRequest(String serverAddress, String servicePath, [Map<String, String> value, TypeHeader type]) async {
    return _makeRequest(serverAddress, servicePath, "get", type, value: value);
  }

  Future<String> makePutRequest(String serverAddress, String servicePath, [Map<String, String> value, TypeHeader type]) async {
    return _makeRequest(serverAddress, servicePath, "get", type, value: value); // this should be put but doesn't work with flutter web actually
  }


}
