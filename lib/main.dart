import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/app/bootstrap/startup_route_resolver.dart';
import 'package:infinity_world/app/router/app_router.dart';
import 'package:infinity_world/app/theme/app_theme.dart';
import 'package:infinity_world/app/theme/app_theme_mode_provider.dart';
import 'package:infinity_world/core/config/constants.dart';
import 'package:infinity_world/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await resolveStartupRoute();

  runApp(ProviderScope(child: MainApp(initialRoute: initialRoute)));
}

class MainApp extends ConsumerWidget {
  MainApp({super.key, this.initialRoute = AppRoutes.login})
    : router = createAppRouter(initialLocation: initialRoute);

  final String initialRoute;
  final GoRouter router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      title: Cfg.appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
    );
  }
}
