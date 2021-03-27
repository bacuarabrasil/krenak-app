import 'package:dio/dio.dart';

import 'package:krenak/Services/Response/LogoutResponse.dart';

class LogoutRequest {

  Future<LogoutResponse> execute() async {
    Dio dio = new Dio();
    Response response = await dio.post(
      'https://b6d151ac60d7.ngrok.io/api/v1/accounts/logout/',
      data: {}
    );
    if (response.statusCode == 200) {
      return LogoutResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }

}
