import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/shell/main_screen.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';

void main() {
  testWidgets('main shell shows the five target bottom tabs', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: MainScreen())),
    );
    await tester.pump();

    final nav = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );

    expect(nav.type, BottomNavigationBarType.fixed);
    expect(nav.items.map((item) => item.label), [
      'Home',
      'Explore',
      'Tools',
      'Library',
      'Settings',
    ]);
    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('main shell switches tabs locally', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: MainScreen())),
    );

    await tester.tap(find.byIcon(Icons.handyman_rounded));
    await tester.pump();

    var nav = tester.widget<BottomNavigationBar>(
      find.byType(BottomNavigationBar),
    );

    expect(nav.currentIndex, 2);
    expect(find.text('Tools'), findsNWidgets(2));
    expect(find.byType(DashboardScreen), findsNothing);

    await tester.tap(find.byIcon(Icons.settings_rounded));
    await tester.pump();

    nav = tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar));

    expect(nav.currentIndex, 4);
    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
