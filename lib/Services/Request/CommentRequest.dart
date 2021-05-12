import 'package:dio/dio.dart';
import 'package:krenak/Scenes/ActivityDetail/Activity.dart';

import 'package:krenak/Services/API.dart';
import 'package:krenak/Services/Request/SessionRequest.dart';

class CommentBody {
  String activity;
  String text;

  CommentBody({this.activity, this.text});
}

class CommentRequest {
  Dio dio;

  CommentRequest([Dio client]) : dio = client ?? API().dio;

  Future<void> execute(CommentBody body) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.post(
      '/comments/',
      data: {
        'author': login.id,
        'activity': body.activity,
        'text': body.text,
      }
    );
    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Unable to perform request!');
    }
  }

  Future<void> delete(String id) async {
    var login = await SessionRequest().execute();
    var access = login.access;
    dio.options.headers['authorization'] = 'Bearer $access';

    Response response = await dio.delete('/comments/' + id + '/');
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Unable to perform request!');
    }
  }
}
