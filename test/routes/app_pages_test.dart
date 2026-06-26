import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/chat/presentation/chat_screen.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';
import 'package:infinity_world/routes/app_pages.dart';
import 'package:infinity_world/routes/app_routes.dart';
import 'package:infinity_world/screens/auth/login_screen.dart';
import 'package:infinity_world/screens/main/main_screen.dart';
import 'package:infinity_world/screens/test/test_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';

void main() {
  tearDown(() {
    Get.reset();
  });

  testWidgets('settings route opens the existing settings screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppRoutes.settings,
        getPages: AppPages.pages,
      ),
    );

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('profile route opens the existing profile screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.profile, getPages: AppPages.pages),
    );

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('chat route opens the existing chat screen', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.chat, getPages: AppPages.pages),
    );

    expect(find.byType(ChatScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login route opens the existing login screen', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.login, getPages: AppPages.pages),
    );

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('main route opens the existing main shell', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.main, getPages: AppPages.pages),
    );

    expect(find.byType(MainScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard route opens the existing dashboard screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: AppRoutes.dashboard,
        getPages: AppPages.pages,
      ),
    );

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BMI route opens the existing BMI screen', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.bmi, getPages: AppPages.pages),
    );

    expect(find.byType(BmiScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('test route opens the existing test screen', (tester) async {
    await tester.pumpWidget(
      GetMaterialApp(initialRoute: AppRoutes.test, getPages: AppPages.pages),
    );

    expect(find.byType(TestScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
