import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/bootstrap/startup_route_resolver.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/screens/main/main_screen.dart';
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

  testWidgets('app starts on the login screen without a local session', (
    tester,
  ) async {
    final initialRoute = await resolveStartupRoute();

    await tester.pumpWidget(MainApp(initialRoute: initialRoute));

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('app starts on the main shell when a local session exists', (
    tester,
  ) async {
    await LocalSessionRepository().saveSession(displayName: 'Minh');
    final initialRoute = await resolveStartupRoute();

    await tester.pumpWidget(MainApp(initialRoute: initialRoute));

    expect(find.byType(MainScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login screen remains scroll-safe with keyboard inset', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(360, 640),
            viewInsets: EdgeInsets.only(bottom: 300),
          ),
          child: const LoginScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.text('Enter InfinityWorld'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
