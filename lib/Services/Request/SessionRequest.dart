import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

abstract class SessionRequestType {
  Future<LoginResponse> execute();
}

class SessionRequest implements SessionRequestType {
  Future<LoginResponse> execute() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var access = await storage.read(key: 'access');
    var refresh = await storage.read(key: 'refresh');
    var id = await storage.read(key: 'id');
    var onboarding = await storage.read(key: 'onboarding');

    return LoginResponse(
      access: access,
      refresh: refresh,
      id: id,
      onboarding: onboarding
    );
  }
}
