import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:infinity_world/core/config/constants.dart';

import 'package:infinity_world/routes/app_pages.dart';
import 'package:infinity_world/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Cfg.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login, // Màn hình mặc định khi khởi động
      getPages: AppPages.pages, // Danh sách các route
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
