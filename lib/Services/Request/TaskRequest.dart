import 'package:dio/dio.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

import 'package:krenak/Services/API.dart';
import 'package:krenak/Services/Request/SessionRequest.dart';

class TaskBody {
  final String title;
  final String activity;

  TaskBody({this.title, this.activity});
}

class TaskPatch {
  final String id;
  final bool done;

  TaskPatch({this.id, this.done});
}

class TaskRequest {
  Dio dio;

  TaskRequest([Dio client]) : dio = client ?? API().dio;

  Future<Task> execute(TaskBody body) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.post(
      '/tasks/',
      data: {
        'is_active': true,
        'title': body.title,
        'done': false,
        'activity': body.activity
      }
    );
    if (response.statusCode == 201) {
      return Task.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  Future<Task> executePath(TaskPatch body) async {
     var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.patch(
      '/tasks/' + body.id + '/',
      data: {
        'done': body.done,
      }
    );
    if (response.statusCode == 201) {
      return Task.fromJson(response.data);
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
