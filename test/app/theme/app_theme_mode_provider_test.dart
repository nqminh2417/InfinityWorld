import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/theme/app_theme_mode_provider.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/app/router/app_routes.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  test('appThemeModeProvider defaults to system mode', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(appThemeModeProvider.future), ThemeMode.system);
  });

  test('appThemeModeProvider reads a persisted theme mode', () async {
    SharedPreferencesAsyncPlatform
        .instance = InMemorySharedPreferencesAsync.withData({
      AppThemeModeRepository.themeModeKey: ThemeMode.dark.name,
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(appThemeModeProvider.future), ThemeMode.dark);
  });

  test('appThemeModeProvider ignores invalid persisted theme mode', () async {
    SharedPreferencesAsyncPlatform
        .instance = InMemorySharedPreferencesAsync.withData({
      AppThemeModeRepository.themeModeKey: 'unexpected',
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(await container.read(appThemeModeProvider.future), ThemeMode.system);
  });

  test('appThemeModeProvider persists updates', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(appThemeModeProvider.future);
    await container
        .read(appThemeModeProvider.notifier)
        .setThemeMode(ThemeMode.light);

    expect(await container.read(appThemeModeProvider.future), ThemeMode.light);
    expect(await AppThemeModeRepository().getThemeMode(), ThemeMode.light);
  });

  testWidgets('MainApp consumes the persisted theme mode provider', (
    tester,
  ) async {
    SharedPreferencesAsyncPlatform
        .instance = InMemorySharedPreferencesAsync.withData({
      AppThemeModeRepository.themeModeKey: ThemeMode.dark.name,
    });

    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.login)),
    );
    await tester.pumpAndSettle();

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.dark);
    expect(tester.takeException(), isNull);
  });
}
