import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/shell/main_screen.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';
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

  testWidgets('login requires a local display name', (tester) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.login));

    await tester.tap(find.text('Enter InfinityWorld'));
    await tester.pump();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Enter a display name'), findsOneWidget);
    expect(await LocalSessionRepository().hasSession(), isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login saves a local profile before opening main', (
    tester,
  ) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.login));

    await tester.enterText(find.byType(TextField), 'Minh');
    await tester.tap(find.text('Enter InfinityWorld'));
    await tester.pumpAndSettle();

    final repository = LocalSessionRepository();
    expect(find.byType(MainScreen), findsOneWidget);
    expect(await repository.hasSession(), isTrue);
    expect(await repository.getDisplayName(), 'Minh');
    expect(tester.takeException(), isNull);
  });

  testWidgets('logout clears the local session before opening login', (
    tester,
  ) async {
    final repository = LocalSessionRepository();
    await repository.saveSession(displayName: 'Minh');

    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.main));

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(await repository.hasSession(), isFalse);
    expect(await repository.getDisplayName(), isNull);
    expect(tester.takeException(), isNull);
  });
}
