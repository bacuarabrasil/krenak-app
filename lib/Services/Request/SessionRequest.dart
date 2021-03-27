import 'package:shared_preferences/shared_preferences.dart';

import 'package:krenak/Services/Response/LoginResponse.dart';

class SessionRequest {

  Future<LoginResponse> execute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return LoginResponse(
      access: prefs.getString('access'),
      refresh: prefs.getString('refresh'),
    );
  }

}
