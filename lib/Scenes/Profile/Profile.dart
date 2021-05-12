class Profile {

  String email;
  String firstName;
  String lastName;
  String birthdate;

  Profile({
    this.email,
    this.firstName,
    this.lastName,
    this.birthdate
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthdate: json['birthdate']
    );
  }
}
