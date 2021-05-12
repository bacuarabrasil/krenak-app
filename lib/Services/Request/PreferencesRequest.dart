import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Onboarding/Onboarding.dart';
import 'package:krenak/Services/API.dart';

import 'SessionRequest.dart';

class PreferencesRequest {
  Dio dio;

  PreferencesRequest([Dio client]) : dio = client ?? API().dio;

  Future<void> execute(Onboarding onboarding) async {
    var session = await SessionRequest().execute();
    var access = session.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.post(
      '/enrollments/',
      data: {
        'resume': onboarding.resume,
        'enrollment_type': onboarding.enrollmentType,
        'enrollee': session.id,
        'interests': onboarding.interests
      }
    );
    if (response.statusCode < 300) {
      return;
    } else {
      var map = response.data as Map;
      var list = map.entries.first.value as List;
      throw map.entries.first.key + ": " + list.first.toString();
    }
  }
}
