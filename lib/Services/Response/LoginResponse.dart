class LoginResponse {

  final String refresh;
  final String access;

  LoginResponse({this.refresh, this.access});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      refresh: json['refresh'],
      access: json['access']
    );
  }
}
