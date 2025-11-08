class AuthModel {
  String accessToken;
  String refreshToken;


  AuthModel({required this.accessToken, required this.refreshToken});

  factory AuthModel.formJson(Map<String, dynamic> json){
    return AuthModel(
      accessToken: json['access_token'] ?? 'No token', 
      refreshToken: json['refresh_token'] ?? 'No token'
    );
  }
}
