import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_world/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final appName = "Infinity World";
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Điều hướng sang MainScreen
            // Navigator.pushReplacementNamed(context, AppRoutes.main);
            // GetX
            Get.offNamed(AppRoutes.main);
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
