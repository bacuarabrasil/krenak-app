import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Register/Model/Register.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

class RegisterRequest {

  Future<LoginResponse> execute(Register register) async {
    Dio dio = new Dio();
    Response response = await dio.post(
      'https://29ea49a5acf1.ngrok.io/api/v1/accounts/registration/',
      data: {
        'email': register.email,
        'first_name': register.firstName,
        'last_name': register.lastName,
        'password': register.password
      }
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }

}
