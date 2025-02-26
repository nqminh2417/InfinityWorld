import 'package:flutter/material.dart';
import 'package:infinity_world/screens/auth/login_screen.dart';
import 'package:infinity_world/screens/chat/chat_screen.dart';
import 'package:infinity_world/screens/dashboard/dashboard_screen.dart';
import 'package:infinity_world/screens/main/main_screen.dart';
import 'package:infinity_world/screens/profile/profile_screen.dart';
import 'package:infinity_world/screens/settings/settings_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> routes = {
    login: (context) => LoginScreen(),
    main: (context) => MainScreen(),
    dashboard: (context) => DashboardScreen(),
    chat: (context) => ChatScreen(),
    profile: (context) => ProfileScreen(),
    settings: (context) => SettingsScreen(),
  };
}
