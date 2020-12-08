import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/Constants.dart';
import 'package:RendicontationPlatformLeo_Client/model/support/ErrorListener.dart';


class RestManager {
  ErrorListener delegate;
  String token;


  Future<String> _makeRequest(String serverAddress, String servicePath, String type, {Map<String, String> body, dynamic value}) async {
    Uri uri = Uri.https(serverAddress, servicePath, value);
    //HttpClient client = new HttpClient();


/*
    HttpClient httpClient = new HttpClient();
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    HttpClientRequest request = await httpClient.postUrl(uri);
    request.headers.add(HttpHeaders.authorizationHeader, 'bearer $token');
    request.headers.add(HttpHeaders.contentTypeHeader, "application/x-www-form-urlencoded");
    //request.add(base64UrlEncode(value));
    await request.write(value);
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(value);
    print(reply);
    return reply;



    await client.postUrl(uri).then((HttpClientRequest request) {
      request.headers.add(HttpHeaders.authorizationHeader, 'bearer $token');
      request.headers.add(HttpHeaders.contentTypeHeader, "application/x-www-form-urlencoded");
      print(value);
      request.write(value);
      return request.close();
    }
    ).then((HttpClientResponse response) {
      response.transform(utf8.decoder).listen((contents) {
        print(contents);

      });
    });
    print("ret");
    return "asdas";
*/
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
        print(response.body);
        return response.body;
      } catch(err, stacktrace) {
        print(err.toString());
        print(stacktrace.toString());
        if ( delegate != null && !errorOccurred ) {
          delegate.errorNetworkOccurred(Constants.MESSAGE_CONNECTION_ERROR);
          errorOccurred = true;
        }
        await Future.delayed(const Duration(seconds: 3), () => null);
      }
    }
  }

  Future<String> makePostRequest(String serverAddress, String servicePath, dynamic value) async {
    return _makeRequest(serverAddress, servicePath, "post", value: value);
  }

  Future<String> makeGetRequest(String serverAddress, String servicePath, [Map<String, String> body]) async {
    return _makeRequest(serverAddress, servicePath, "get", body: body);
  }

  Future<String> makePutRequest(String serverAddress, String servicePath, Map<String, String> body) async {
    return _makeRequest(serverAddress, servicePath, "get", body: body); // this should be put but doesn't work with flutter web actually
  }


}
