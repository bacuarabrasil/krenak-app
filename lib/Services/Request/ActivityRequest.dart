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

  Future<Activity> getActivity(String id) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.get('/activities/' + id + '/');
    if (response.statusCode == 200) {
      return Activity.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  Future<List<Activity>> getActivities(String mentorship) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.get('/activities/');
    if (response.statusCode == 200) {
      var list = response.data['results'] as List;
      List<Activity> results = list.map((i) => Activity.fromJson(i)).where((element) => element.mentorship == mentorship).toList();
      return results;
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
