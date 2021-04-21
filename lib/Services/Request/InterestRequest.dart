import 'package:dio/dio.dart';
import 'package:krenak/Services/API.dart';
import 'package:krenak/Services/Response/InterestResponse.dart';

import 'SessionRequest.dart';

class InterestRequest {
  Dio dio;

  InterestRequest([Dio client]) : dio = client ?? API().dio;

  Future<InterestResponse> execute() async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.get('/interests/');
    if (response.statusCode == 200) {
      return InterestResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
