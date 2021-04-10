class LoginResponse {
  final String refresh;
  final String access;
  final int id;

  LoginResponse({this.refresh, this.access, this.id});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        refresh: json['refresh'], access: json['access'], id: json['id']);
  }
}
