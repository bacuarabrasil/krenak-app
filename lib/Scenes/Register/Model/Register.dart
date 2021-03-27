class Register {

  String email;
  String firstName;
  String lastName;
  String password;

  Register({
    this.email,
    this.firstName,
    this.lastName,
    this.password
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      password: json['password']
    );
  }
}
