import 'package:dio/dio.dart';

class API {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://7037926f5db5.ngrok.io/api/v1',
    responseType: ResponseType.json,
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
