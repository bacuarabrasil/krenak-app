import 'package:flutter/material.dart';

import 'package:krenak/Scenes/Login/Model/Login.dart';
import 'package:krenak/Scenes/Register/Model/Register.dart';
import 'package:krenak/Services/Request/LoginRequest.dart';
import 'package:krenak/Services/Request/LogoutRequest.dart';
import 'package:krenak/Services/Request/RegisterRequest.dart';
import 'package:krenak/Services/Request/SessionRequest.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/Store/SessionStore.dart';

class AuthStore with ChangeNotifier {
  var currentUser;

  static AuthStore shared = AuthStore();

  Future<LoginResponse> get user async {
    var session = await SessionRequest().execute();
    this.currentUser = session;
    notifyListeners();
    return Future.value(session);
  }

  Future logout() async {
    this.currentUser = null;
    await LogoutRequest().execute();
    var session = LoginResponse(access: null, refresh: null);
    await SessionStore().execute(session);
    notifyListeners();
    return Future.value(currentUser);
  }

  Future createUser(Register register) async {
    var response = await RegisterRequest().execute(register);
    await SessionStore().execute(response);
    this.currentUser = await SessionRequest().execute();
    notifyListeners();
  }

  Future loginUser(Login login) async {
    var response = await LoginRequest().execute(login);
    await SessionStore().execute(response);
    this.currentUser = await SessionRequest().execute();
    notifyListeners();
  }
}