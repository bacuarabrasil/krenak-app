import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';

class SessionRequest {
  Future<LoginResponse> execute() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    var access = await storage.read(key: 'access');
    var refresh = await storage.read(key: 'refresh');
    var id = await storage.read(key: 'id');
    return LoginResponse(
        access: access, refresh: refresh, id: int.parse(id ?? "1"));
  }
}
