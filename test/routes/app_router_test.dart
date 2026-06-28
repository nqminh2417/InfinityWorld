import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/shell/main_screen.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/chat/presentation/chat_screen.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';
import 'package:infinity_world/features/test/presentation/test_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';

void main() {
  testWidgets('settings route opens the existing settings screen', (
    tester,
  ) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.settings));

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('profile route opens the existing profile screen', (
    tester,
  ) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.profile));

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('chat route opens the existing chat screen', (tester) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.chat));

    expect(find.byType(ChatScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login route opens the existing login screen', (tester) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.login));

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('main route opens the existing main shell', (tester) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.main));

    expect(find.byType(MainScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard route opens the existing dashboard screen', (
    tester,
  ) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.dashboard));

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BMI route opens the existing BMI screen', (tester) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.bmi));

    expect(find.byType(BmiScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('test route opens the existing test screen', (tester) async {
    await tester.pumpWidget(MainApp(initialRoute: AppRoutes.test));

    expect(find.byType(TestScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
