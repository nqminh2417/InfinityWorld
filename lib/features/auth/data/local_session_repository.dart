import 'package:shared_preferences/shared_preferences.dart';

class LocalSessionRepository {
  LocalSessionRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String isLoggedInKey = 'iw_is_logged_in';
  static const String displayNameKey = 'iw_display_name';

  final SharedPreferencesAsync _preferences;

  Future<bool> hasSession() async {
    final isLoggedIn = await _preferences.getBool(isLoggedInKey) ?? false;
    if (!isLoggedIn) {
      return false;
    }

    return await getDisplayName() != null;
  }

  Future<String?> getDisplayName() async {
    final displayName = (await _preferences.getString(displayNameKey))?.trim();
    return displayName == null || displayName.isEmpty ? null : displayName;
  }

  Future<void> saveSession({required String displayName}) async {
    final trimmedDisplayName = displayName.trim();
    if (trimmedDisplayName.isEmpty) {
      throw ArgumentError.value(
        displayName,
        'displayName',
        'must not be blank',
      );
    }

    await _preferences.setBool(isLoggedInKey, true);
    await _preferences.setString(displayNameKey, trimmedDisplayName);
  }

  Future<void> clearSession() async {
    await _preferences.remove(isLoggedInKey);
    await _preferences.remove(displayNameKey);
  }
}
