

class AuthenticationData {
  String accessToken;
  String refreshToken;
  int expiresIn;


  AuthenticationData({this.accessToken, this.refreshToken, this.expiresIn,});

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
    );
  }


}