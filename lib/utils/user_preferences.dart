import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> saveUsername(String username) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('username', username);
  }

  static Future<String?> getUsername() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('username');
  }

  static Future<void> clearUsername() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('username');
  }
}
