import 'package:dio/dio.dart';
import 'package:krenak/Services/API.dart';
import 'package:krenak/Services/Response/MentorshipsResponse.dart';

import 'SessionRequest.dart';

class MentorshipsRequest {
  Dio dio;

  MentorshipsRequest([Dio client]) : dio = client ?? API().dio;

  Future<MentorshipsResponse> execute() async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.get('/mentorships/');
    if (response.statusCode == 200) {
      return MentorshipsResponse.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
