import 'package:dio/dio.dart';

class API {
  static var uri = 'https://e57cdcaef1ae.ngrok.io/api/v1';
  static BaseOptions options = BaseOptions(
    baseUrl: uri,
    responseType: ResponseType.plain,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    validateStatus: (code) {
      if (code >= 200) {
        return true;
      }
      return false;
    }
  );
  static Dio dio = Dio(options);
}
