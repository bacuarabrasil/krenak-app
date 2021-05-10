class MeResponse {

  final String email;
  final String firstName;
  final String lastName;
  final String birthdate;
  final String role;

  MeResponse({
    this.email,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.role
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthdate: json['birthdate'],
      role: json['role']
    );
  }
}
