import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Onboarding/Onboarding.dart';
import 'package:krenak/Services/API.dart';

import 'SessionRequest.dart';

class PreferencesRequest {
  Dio dio;

  PreferencesRequest([Dio client]) : dio = client ?? API.shared.dio;

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
      throw Exception('Unable to perform request!');
    }
  }
}
