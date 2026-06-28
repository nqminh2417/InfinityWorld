import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/features/auth/data/local_session_repository.dart';
import 'package:infinity_world/routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoggingOut = false;

  void _toFoxRandom() {
    context.push(AppRoutes.fox);
  }

  void _toTestScreen() {
    context.push(AppRoutes.test);
  }

  Future<void> _logout() async {
    if (_isLoggingOut) {
      return;
    }

    _isLoggingOut = true;
    try {
      await LocalSessionRepository().clearSession();
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.login);
    } finally {
      _isLoggingOut = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.beach_access),
              title: const Text('Summertime Saga'),
              onTap: () {
                context.push(AppRoutes.smtsHome);
              },
            ),
            ListTile(
              leading: const Icon(Icons.start),
              title: const Text('Random pictures of foxes'),
              onTap: _toFoxRandom,
            ),
            ListTile(
              leading: const Icon(Icons.arrow_forward_rounded),
              title: const Text('BMI Calculator'),
              onTap: () {
                context.push(AppRoutes.bmi);
              },
            ),
            ListTile(
              leading: const Icon(Icons.swipe_vertical),
              title: const Text('Test Screen'),
              onTap: _toTestScreen,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
