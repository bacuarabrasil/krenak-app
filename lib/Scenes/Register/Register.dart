class Register {

  String email;
  String firstName;
  String lastName;
  String password;
  String birthdate;

  Register({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.birthdate
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password'],
      birthdate: json['birthdate']
    );
  }
}
