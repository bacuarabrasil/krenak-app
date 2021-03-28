import 'package:dio/dio.dart';

import 'package:krenak/Services/Request/SessionRequest.dart';

class LogoutRequest {

  Future<void> execute() async {
    Dio dio = new Dio();
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.post('https://29ea49a5acf1.ngrok.io/api/v1/accounts/logout/');
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Unable to perform request!');
    }
  }

}
