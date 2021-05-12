import 'package:dio/dio.dart';
import 'package:krenak/Scenes/Profile/Profile.dart';
import 'package:krenak/Services/API.dart';

import 'package:krenak/Services/Request/SessionRequest.dart';
import 'package:krenak/Services/Response/MeResponse.dart';

class MeRequest {
  Dio dio;
  SessionRequestType sessionRequest;

  static MeRequest shared = MeRequest();

  MeResponse meResponse;

  MeRequest([Dio client, SessionRequestType sessionRequest])
    : dio = client ?? API().dio,
    sessionRequest = sessionRequest ?? SessionRequest();

  Future<MeResponse> execute() async {
    var login = await sessionRequest.execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.get('/accounts/me/');
    if (response.statusCode == 200) {
      meResponse = MeResponse.fromJson(response.data);
      return meResponse;
    } else {
      var map = response.data as Map;
      var list = map.entries.first.value as List;
      throw map.entries.first.key + ": " + list.first.toString();
    }
  }

  Future<MeResponse> update(Profile profile) async {
    var login = await sessionRequest.execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';
    Response response = await dio.patch(
      '/accounts/me/',
      data: {
        'email': profile.email ?? '',
        'first_name': profile.firstName ?? '',
        'last_name': profile.lastName ?? '',
        'birthdate': profile.birthdate
      }
    );
    if (response.statusCode == 200) {
      meResponse = MeResponse.fromJson(response.data);
      return meResponse;
    } else {
      var map = response.data as Map;
      var list = map.entries.first.value as List;
      throw map.entries.first.key + ": " + list.first.toString();
    }
  }
}
