class LogoutResponse {

  final String refresh;
  final String access;

  LogoutResponse({this.refresh, this.access});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      refresh: json['refresh'],
      access: json['access']
    );
  }
}
