import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Register/Register.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/API.dart';

class RegisterRequest {
  Dio dio;

  RegisterRequest([Dio client]) : dio = client ?? API().dio;

  Future<LoginResponse> execute(Register register) async {
    Response response = await dio.post(
      '/accounts/registration/',
      data: {
        'email': register.email,
        'first_name': register.firstName,
        'birthdate': register.birthdate,
        'last_name': register.lastName,
        'password': register.password
      }
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      var map = response.data as Map;
      var list = map.entries.first.value as List;
      throw map.entries.first.key + ": " + list.first.toString();
    }
  }
}
