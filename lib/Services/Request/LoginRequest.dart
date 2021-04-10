import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Login/Login.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

class LoginRequest {
  Future<LoginResponse> execute(Login login) async {
    Dio dio = new Dio();
    Response response = await dio.post(
        'https://644236199a13.ngrok.io/api/v1/accounts/login/',
        data: {'email': login.email, 'password': login.password});
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
