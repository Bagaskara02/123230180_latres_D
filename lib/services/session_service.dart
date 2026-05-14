import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static const String _keyUsername = 'username';

  static Future<void> saveSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  static Future<String?> getSession() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUsername);
  }

  static Future<bool> isLoggedIn() async {
    final username = await getSession();
    return username != null && username.isNotEmpty;
  }
}
