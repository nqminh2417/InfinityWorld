import 'package:get/get.dart';
import 'package:infinity_world/routes/app_routes.dart';
import 'package:infinity_world/screens/auth/login_screen.dart';
import 'package:infinity_world/screens/chat/chat_screen.dart';
import 'package:infinity_world/screens/dashboard/dashboard_screen.dart';
import 'package:infinity_world/screens/fox/fox_random_screen.dart';
import 'package:infinity_world/screens/main/main_screen.dart';
import 'package:infinity_world/screens/profile/profile_screen.dart';
import 'package:infinity_world/screens/summertime_saga/smts_home_screen.dart';
import 'package:infinity_world/screens/test/test_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.main, page: () => MainScreen()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.chat, page: () => ChatScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.smtsHome, page: () => SmtsHomeScreen()),
    GetPage(name: AppRoutes.test, page: () => TestScreen()),
    GetPage(name: AppRoutes.fox, page: () => FoxRandomScreen()),
  ];
}
