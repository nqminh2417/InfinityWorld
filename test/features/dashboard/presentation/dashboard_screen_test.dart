import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/random_picker/presentation/random_picker_screen.dart';
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

  testWidgets('Dashboard screen remains scroll-safe on small screens', (
    tester,
  ) async {
    await LocalSessionRepository().saveSession(displayName: 'Minh');
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: DashboardScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SafeArea), findsWidgets);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsWidgets);
    expect(find.byIcon(Icons.filter_list), findsNothing);
    expect(find.text('Welcome back, Minh'), findsOneWidget);
    expect(find.text('Quick actions'), findsOneWidget);
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Clock'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Random Picker'), 120);
    expect(find.text('Random Picker'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Random Fox'), 120);
    expect(find.text('Random Fox'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Summertime Saga'), 120);
    expect(find.text('Summertime Saga'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Test Screen'), 120);
    expect(find.text('Test Screen'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Log out'), -120);
    expect(find.text('Log out'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Dashboard Random Picker quick action opens the existing route', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Random Picker'));
    await tester.tap(find.text('Random Picker'));
    await tester.pumpAndSettle();

    expect(find.byType(RandomPickerScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
