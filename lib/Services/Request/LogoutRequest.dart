import 'package:dio/dio.dart';

class LogoutRequest {

  Future<void> execute() async {
    Dio dio = new Dio();
    Response response = await dio.post(
      'https://b6d151ac60d7.ngrok.io/api/v1/accounts/logout/',
      data: {}
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Unable to perform request!');
    }
  }

}
