import 'package:shared_preferences/shared_preferences.dart';

class TokenStorageService {
  static const _key = 'access_token';

  final SharedPreferences prefs;

  TokenStorageService(this.prefs);

  Future<void> saveToken(String token) async {
    await prefs.setString(_key, token);
  }

  String? getToken() {
    return prefs.getString(_key);
  }

  Future<void> clearToken() async {
    await prefs.remove(_key);
  }
}