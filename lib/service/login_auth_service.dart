import 'package:get_storage/get_storage.dart';

class AuthTokenService {
  AuthTokenService._instance();
  static final AuthTokenService _authTokenService =
      AuthTokenService._instance();
  factory AuthTokenService() => _authTokenService;

  final box = GetStorage();

  final String key = 'AUTH_KEY';

  setAuthTokenToBox(String? authKey) {
    box.write(key, "Bearer $authKey");
  }

  String getAuthTokenFromBox() {
    return box.read(key) ?? "";
  }

  clearAuth() {
    box.remove(key);
  }
}
