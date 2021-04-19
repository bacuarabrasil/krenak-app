import 'package:dio/dio.dart';
import 'package:krenak/Scenes/Profile/Profile.dart';
import 'package:krenak/Services/API.dart';

import 'package:krenak/Services/Request/SessionRequest.dart';
import 'package:krenak/Services/Response/MeResponse.dart';

class MeRequest {
  Dio dio;

  MeRequest([Dio client]) : dio = client ?? API.dio;

  Future<MeResponse> execute() async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.get('/accounts/me/');
    if (response.statusCode == 200) {
      return MeResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  Future<MeResponse> update(Profile profile) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.patch(
      '/accounts/me/',
      data: {
        'email': profile.email ?? '',
        'first_name': profile.firstName ?? '',
        'last_name': profile.lastName ?? ''
      }
    );
    if (response.statusCode == 200) {
      return MeResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
