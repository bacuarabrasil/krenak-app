import 'package:dio/dio.dart';

import 'package:krenak/Services/API.dart';
import 'package:krenak/Scenes/Login/Login.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

class LoginRequest {
  Dio dio;

  LoginRequest([Dio client]) : dio = client ?? API().dio;

  Future<LoginResponse> execute(Login login) async {
    Response response = await dio.post(
      '/accounts/login/',
      data: {
        'email': login.email,
        'password': login.password
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
