import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appThemeModeRepositoryProvider = Provider<AppThemeModeRepository>((ref) {
  return AppThemeModeRepository();
});

final appThemeModeProvider =
    AsyncNotifierProvider<AppThemeModeController, ThemeMode>(
      AppThemeModeController.new,
    );

class AppThemeModeController extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() {
    return ref.watch(appThemeModeRepositoryProvider).getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await ref.read(appThemeModeRepositoryProvider).saveThemeMode(themeMode);
    state = AsyncData(themeMode);
  }
}

class AppThemeModeRepository {
  AppThemeModeRepository({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const String themeModeKey = 'iw_theme_mode';

  final SharedPreferencesAsync _preferences;

  Future<ThemeMode> getThemeMode() async {
    final value = await _preferences.getString(themeModeKey);
    return _decodeThemeMode(value) ?? ThemeMode.system;
  }

  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _preferences.setString(themeModeKey, themeMode.name);
  }

  ThemeMode? _decodeThemeMode(String? value) {
    return switch (value?.trim()) {
      'system' => ThemeMode.system,
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => null,
    };
  }
}
