import 'package:dio/dio.dart';

class API {
  Dio dio = Dio(BaseOptions(
    baseUrl: 'https://damp-sands-76071.herokuapp.com/api/v1',
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
