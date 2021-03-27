import 'package:shared_preferences/shared_preferences.dart';

import 'package:krenak/Services/Response/LoginResponse.dart';

class SessionStore {

  Future<void> execute(LoginResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', response.access);
    await prefs.setString('refresh', response.refresh);
  }

}
