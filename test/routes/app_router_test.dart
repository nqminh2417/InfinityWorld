import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/app/router/app_router.dart';
import 'package:infinity_world/app/shell/main_screen.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/chat/presentation/chat_screen.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/fox/data/fox_api_service.dart';
import 'package:infinity_world/features/fox/domain/fox_model.dart';
import 'package:infinity_world/features/fox/presentation/fox_random_screen.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';
import 'package:infinity_world/features/summertime_saga/domain/smts_progress_model.dart';
import 'package:infinity_world/features/summertime_saga/presentation/smts_home_screen.dart';
import 'package:infinity_world/features/test/presentation/test_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';

void main() {
  testWidgets('settings route opens the existing settings screen', (
    tester,
  ) async {
    await tester.pumpWidget(_app(AppRoutes.settings));

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('profile route opens the existing profile screen', (
    tester,
  ) async {
    await tester.pumpWidget(_app(AppRoutes.profile));

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('chat route opens the existing chat screen', (tester) async {
    await tester.pumpWidget(_app(AppRoutes.chat));

    expect(find.byType(ChatScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('login route opens the existing login screen', (tester) async {
    await tester.pumpWidget(_app(AppRoutes.login));

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('main route opens the existing main shell', (tester) async {
    await tester.pumpWidget(_app(AppRoutes.main));

    expect(find.byType(MainScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('dashboard route opens the existing dashboard screen', (
    tester,
  ) async {
    await tester.pumpWidget(_app(AppRoutes.dashboard));

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BMI route opens the existing BMI screen', (tester) async {
    await tester.pumpWidget(_app(AppRoutes.bmi));

    expect(find.byType(BmiScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('test route opens the existing test screen', (tester) async {
    await tester.pumpWidget(_app(AppRoutes.test));

    expect(find.byType(TestScreen), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Fox route opens without live network', (tester) async {
    final pendingFox = Completer<FoxModel>();
    var requestCount = 0;

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: createAppRouter(
          initialLocation: AppRoutes.fox,
          foxRouteBuilder:
              (_, __) => FoxRandomScreen(
                service: _FakeFoxApiService(() {
                  requestCount++;

                  return pendingFox.future;
                }),
              ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(FoxRandomScreen), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(requestCount, 1);
    expect(tester.takeException(), isNull);

    pendingFox.completeError(const FoxApiException('Failed to load fox: 500'));
    await tester.pump();
  });

  testWidgets('Summertime Saga route opens without live network', (
    tester,
  ) async {
    final pendingProgress = Completer<SmtsProgressModel>();
    var requestCount = 0;

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: createAppRouter(
          initialLocation: AppRoutes.smtsHome,
          smtsHomeRouteBuilder:
              (_, __) => SmtsHomeScreen(
                logoUrl: '',
                loadProgress: () {
                  requestCount++;

                  return pendingProgress.future;
                },
              ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SmtsHomeScreen), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(requestCount, 1);
    expect(tester.takeException(), isNull);

    pendingProgress.complete(SmtsProgressModel(version: '0.20.16'));
    await tester.pump();
  });
}

Widget _app(String initialRoute) {
  return ProviderScope(child: MainApp(initialRoute: initialRoute));
}

class _FakeFoxApiService extends FoxApiService {
  _FakeFoxApiService(this._load);

  final Future<FoxModel> Function() _load;

  @override
  Future<FoxModel> getRandomFox() => _load();
}
