import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinity_world/routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  void _toFoxRandom() async {
    Get.toNamed(AppRoutes.fox);
  }

  void _toTestScreen() async {
    Get.toNamed(AppRoutes.test);
  }

  void _logout() async {
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {})],
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.beach_access),
            title: Text('Summertime Saga'),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SmtsHomeScreen()));
              Get.toNamed(AppRoutes.smtsHome);
            },
          ),
          ListTile(
            leading: const Icon(Icons.start),
            title: const Text('Random pictures of foxes'),
            onTap: _toFoxRandom,
          ),
          ListTile(leading: const Icon(Icons.swipe_vertical), title: const Text('Test Screen'), onTap: _toTestScreen),
          ListTile(leading: const Icon(Icons.logout), title: const Text('Log out'), onTap: _logout),
        ],
      ),
    );
  }
}
