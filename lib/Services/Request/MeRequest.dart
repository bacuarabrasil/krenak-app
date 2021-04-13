import 'package:dio/dio.dart';
import 'package:krenak/Scenes/Profile/Profile.dart';

import 'package:krenak/Services/Request/SessionRequest.dart';
import 'package:krenak/Services/Response/MeResponse.dart';

class MeRequest {
  Future<MeResponse> execute() async {
    Dio dio = new Dio();
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.get('https://b0173ba3cce0.ngrok.io/api/v1/accounts/me/');
    if (response.statusCode == 200) {
      return MeResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  Future<MeResponse> update(Profile profile) async {
    Dio dio = new Dio();
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio
        .patch('https://b0173ba3cce0.ngrok.io/api/v1/accounts/me/', data: {
      'email': profile.email ?? '',
      'first_name': profile.firstName ?? '',
      'last_name': profile.lastName ?? ''
    });
    if (response.statusCode == 200) {
      return MeResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
