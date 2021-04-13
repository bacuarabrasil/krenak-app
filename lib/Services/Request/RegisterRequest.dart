import 'dart:math';

import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Register/Register.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

class RegisterRequest {
  Future<LoginResponse> execute(Register register) async {
    Dio dio = new Dio();
    try {
      Response response = await dio.post(
          'https://b0173ba3cce0.ngrok.io/api/v1/accounts/registration/',
          data: {
            'email': register.email,
            'first_name': register.firstName,
            'birthdate': register.birthdate,
            'last_name': register.lastName,
            'password': register.password
          });
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception('Unable to perform request!');
      }
    } on DioError catch (e) {
      print(e.response);
      throw Exception("DEU ERRO");
    }
  }
}
