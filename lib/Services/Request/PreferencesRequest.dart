import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:krenak/Scenes/Login/Login.dart';
import 'package:krenak/Scenes/Onboarding/Onboarding.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

import 'SessionRequest.dart';

class PreferencesRequest {
  Future<void> execute(Onboarding onboarding) async {
    Dio dio = new Dio();
    var session = await SessionRequest().execute();
    var access = session.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio
        .post('https://e57cdcaef1ae.ngrok.io/api/v1/enrollments', data: {
      'resume': onboarding.resume,
      'enrollment_type': onboarding.enrollmentType,
      'enrollee': session.id,
      'interests': onboarding.interests
    });
    if (response.statusCode < 300) {
      return;
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
