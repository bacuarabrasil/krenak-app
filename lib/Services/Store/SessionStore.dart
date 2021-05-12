import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

class SessionStore {
  Future<void> execute(LoginResponse response) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: 'access', value: response.access);
    await storage.write(key: 'refresh', value: response.refresh);
    await storage.write(key: 'id', value: response.id.toString());
  }
}
