import 'package:flutter/material.dart';

import 'package:krenak/Scenes/Login/Model/Login.dart';
import 'package:krenak/Scenes/Register/Model/Register.dart';
import 'package:krenak/Services/Request/LoginRequest.dart';
import 'package:krenak/Services/Request/RegisterRequest.dart';
import 'package:krenak/Services/Request/SessionRequest.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/Store/SessionStore.dart';

class AuthStore with ChangeNotifier {
  var currentUser;

  Future<LoginResponse> getUser() {
    return Future.value(currentUser);
  }

  Future logout() {
    this.currentUser = null;
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