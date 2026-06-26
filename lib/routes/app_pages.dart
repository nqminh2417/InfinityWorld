import 'package:get/get.dart';
import 'package:infinity_world/features/auth/presentation/login_screen.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';
import 'package:infinity_world/features/chat/presentation/chat_screen.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/fox/presentation/fox_random_screen.dart';
import 'package:infinity_world/features/profile/presentation/profile_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';
import 'package:infinity_world/features/test/presentation/test_screen.dart';
import 'package:infinity_world/routes/app_routes.dart';
import 'package:infinity_world/screens/main/main_screen.dart';
import 'package:infinity_world/screens/summertime_saga/smts_home_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(name: AppRoutes.main, page: () => MainScreen()),
    GetPage(name: AppRoutes.dashboard, page: () => DashboardScreen()),
    GetPage(name: AppRoutes.chat, page: () => ChatScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
    GetPage(name: AppRoutes.settings, page: () => SettingsScreen()),
    GetPage(name: AppRoutes.smtsHome, page: () => SmtsHomeScreen()),
    GetPage(name: AppRoutes.test, page: () => TestScreen()),
    GetPage(name: AppRoutes.fox, page: () => FoxRandomScreen()),
    GetPage(name: AppRoutes.bmi, page: () => BmiScreen()),
  ];
}
