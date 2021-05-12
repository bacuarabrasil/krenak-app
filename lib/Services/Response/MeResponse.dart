class MeResponse {

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String birthdate;
  final String role;

  MeResponse({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.role
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) {
    return MeResponse(
      id: json['id'].toString(),
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthdate: json['birthdate'],
      role: json['role']
    );
  }
}
