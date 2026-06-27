import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/routes/app_pages.dart';
import 'package:infinity_world/routes/app_routes.dart';
import 'package:infinity_world/screens/main/main_screen.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    Get.reset();
    SharedPreferencesAsyncPlatform.instance = null;
  });

  testWidgets('login saves a local session before opening main', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.login, getPages: AppPages.pages),
    );

    await tester.tap(find.text('Sign in'));
    await tester.pumpAndSettle();

    expect(find.byType(MainScreen), findsOneWidget);
    expect(await LocalSessionRepository().hasSession(), isTrue);
    expect(tester.takeException(), isNull);
  });

  testWidgets('logout clears the local session before opening login', (
    tester,
  ) async {
    final repository = LocalSessionRepository();
    await repository.saveSession();

    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.main, getPages: AppPages.pages),
    );

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(await repository.hasSession(), isFalse);
    expect(tester.takeException(), isNull);
  });
}
