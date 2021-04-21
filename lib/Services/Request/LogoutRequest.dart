import 'package:dio/dio.dart';
import 'package:krenak/Services/API.dart';

import 'package:krenak/Services/Request/SessionRequest.dart';

class LogoutRequest {
  Dio dio;

  LogoutRequest([Dio client]) : dio = client ?? API().dio;

  Future<void> execute() async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.post('/accounts/logout/');
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
