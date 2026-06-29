import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/theme/app_theme_mode_provider.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';

void main() {
  test('appThemeModeProvider defaults to system mode', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });

  testWidgets('MainApp consumes the app theme mode provider', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appThemeModeProvider.overrideWithValue(ThemeMode.dark)],
        child: MainApp(initialRoute: AppRoutes.login),
      ),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    expect(materialApp.themeMode, ThemeMode.dark);
    expect(tester.takeException(), isNull);
  });
}
