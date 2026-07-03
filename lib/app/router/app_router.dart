import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/app/shell/main_screen.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/chat/presentation/chat_screen.dart';
import 'package:infinity_world/features/clock/presentation/clock_screen.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/fox/application/fox_providers.dart';
import 'package:infinity_world/features/fox/presentation/fox_random_screen.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';
import 'package:infinity_world/features/random_picker/presentation/random_picker_screen.dart';
import 'package:infinity_world/features/reader/presentation/reader_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';
import 'package:infinity_world/features/summertime_saga/application/smts_providers.dart';
import 'package:infinity_world/features/summertime_saga/presentation/smts_home_screen.dart';
import 'package:infinity_world/features/test/presentation/test_screen.dart';
import 'package:infinity_world/routes/app_routes.dart';

GoRouter createAppRouter({
  String initialLocation = AppRoutes.login,
  GoRouterWidgetBuilder? smtsHomeRouteBuilder,
  GoRouterWidgetBuilder? foxRouteBuilder,
}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.chat,
        builder: (BuildContext context, GoRouterState state) {
          return const ChatScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.smtsHome,
        builder:
            smtsHomeRouteBuilder ??
            (BuildContext context, GoRouterState state) {
              return Consumer(
                builder: (context, ref, _) {
                  return SmtsHomeScreen(
                    loadProgress: ref.watch(smtsServiceProvider).fetchProgress,
                  );
                },
              );
            },
      ),
      GoRoute(
        path: AppRoutes.test,
        builder: (BuildContext context, GoRouterState state) {
          return const TestScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.fox,
        builder:
            foxRouteBuilder ??
            (BuildContext context, GoRouterState state) {
              return Consumer(
                builder: (context, ref, _) {
                  return FoxRandomScreen(
                    service: ref.watch(foxApiServiceProvider),
                  );
                },
              );
            },
      ),
      GoRoute(
        path: AppRoutes.bmi,
        builder: (BuildContext context, GoRouterState state) {
          return const BmiScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.clock,
        builder: (BuildContext context, GoRouterState state) {
          return const ClockScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.randomPicker,
        builder: (BuildContext context, GoRouterState state) {
          return const RandomPickerScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.reader,
        builder: (BuildContext context, GoRouterState state) {
          return const ReaderScreen();
        },
      ),
    ],
  );
}
