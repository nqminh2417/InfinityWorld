import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:infinity_world/routes/app_routes.dart';
import 'package:infinity_world/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load file .env theo biến ENV được truyền từ launch.json
  String envFile = const String.fromEnvironment('ENV', defaultValue: 'env/.env.dev');
  await dotenv.load(fileName: envFile); // Load file .env

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Infinity World',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login, // Màn hình mặc định khi khởi động
      getPages: AppPages.pages, // Danh sách các route
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
