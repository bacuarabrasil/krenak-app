class LoginResponse {
  final String refresh;
  final String access;
  final String id;
  final String onboarding;

  LoginResponse({this.refresh, this.access, this.id, this.onboarding});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        refresh: json['refresh'],
        access: json['access'],
        id: json['id'].toString(),
        onboarding: 'no');
  }
}
