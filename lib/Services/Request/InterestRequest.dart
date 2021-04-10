import 'package:dio/dio.dart';
import 'package:krenak/Services/Response/InterestResponse.dart';

import 'SessionRequest.dart';

class InterestRequest {
  Future<InterestResponse> execute() async {
    Dio dio = new Dio();
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response =
        await dio.get('https://644236199a13.ngrok.io/api/v1/interests');
    if (response.statusCode == 200) {
      return InterestResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
