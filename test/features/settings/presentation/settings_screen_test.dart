import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/theme/app_theme_mode_provider.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';
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

  testWidgets('Settings screen shows the local profile display name', (
    tester,
  ) async {
    await LocalSessionRepository().saveSession(displayName: 'Minh');
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsScreen())),
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsNWidgets(2));
    expect(find.text('Local profile'), findsOneWidget);
    expect(find.text('Minh'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Theme mode'), findsOneWidget);
    expect(find.text('System'), findsWidgets);
    expect(_selectedThemeMode(tester), ThemeMode.system);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Settings screen shows persisted theme mode summary', (
    tester,
  ) async {
    SharedPreferencesAsyncPlatform
        .instance = InMemorySharedPreferencesAsync.withData({
      AppThemeModeRepository.themeModeKey: ThemeMode.dark.name,
    });

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Theme mode'), findsOneWidget);
    expect(find.text('Dark'), findsWidgets);
    expect(_selectedThemeMode(tester), ThemeMode.dark);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Settings screen persists selected theme mode', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: SettingsScreen())),
    );
    await tester.pumpAndSettle();

    expect(_selectedThemeMode(tester), ThemeMode.system);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();

    expect(_selectedThemeMode(tester), ThemeMode.light);
    expect(await AppThemeModeRepository().getThemeMode(), ThemeMode.light);
    expect(tester.takeException(), isNull);
  });
}

ThemeMode _selectedThemeMode(WidgetTester tester) {
  final segmentedButton = tester.widget<SegmentedButton<ThemeMode>>(
    find.byType(SegmentedButton<ThemeMode>),
  );

  return segmentedButton.selected.single;
}
