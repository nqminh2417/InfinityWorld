import 'package:flutter/material.dart';
import 'package:infinity_world/routes/app_routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'InfinityWorld', debugShowCheckedModeBanner: false, initialRoute: AppRoutes.login, routes: AppRoutes.routes, theme: ThemeData(primarySwatch: Colors.blue));
  }
}
