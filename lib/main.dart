import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:infinity_world/app/bootstrap/startup_route_resolver.dart';
import 'package:infinity_world/app/theme/app_theme.dart';
import 'package:infinity_world/core/config/constants.dart';

import 'package:infinity_world/routes/app_pages.dart';
import 'package:infinity_world/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialRoute = await resolveStartupRoute();

  runApp(MainApp(initialRoute: initialRoute));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.initialRoute = AppRoutes.login});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Cfg.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
