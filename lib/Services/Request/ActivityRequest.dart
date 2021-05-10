import 'package:dio/dio.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

import 'package:krenak/Services/API.dart';
import 'package:krenak/Services/Request/SessionRequest.dart';

class ActivityBody {
  final String title;
  final String description;
  final String mentorship;

  ActivityBody({this.title, this.description, this.mentorship});
}

class ActivityRequest {
  Dio dio;

  ActivityRequest([Dio client]) : dio = client ?? API().dio;

  Future<Activity> execute(ActivityBody body) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.post(
      '/activities/',
      data: {
        'title': body.title,
        'description': body.description,
        'mentorship': body.mentorship
      }
    );
    if (response.statusCode == 201) {
      return Activity.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
