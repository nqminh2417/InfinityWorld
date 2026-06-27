import 'package:shared_preferences/shared_preferences.dart';

class LocalSessionRepository {
  LocalSessionRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String isLoggedInKey = 'iw_is_logged_in';

  final SharedPreferencesAsync _preferences;

  Future<bool> hasSession() async {
    return await _preferences.getBool(isLoggedInKey) ?? false;
  }

  Future<void> saveSession() {
    return _preferences.setBool(isLoggedInKey, true);
  }

  Future<void> clearSession() {
    return _preferences.remove(isLoggedInKey);
  }
}
