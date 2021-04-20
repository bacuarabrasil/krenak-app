import 'package:dio/dio.dart';

class API {
  static var shared = API();

  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://f41926d76302.ngrok.io/api/v1',
    responseType: ResponseType.plain,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    validateStatus: (code) {
      if (code >= 200) {
        return true;
      }
      return false;
    }
  ));
}
