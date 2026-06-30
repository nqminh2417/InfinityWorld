import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/dashboard/presentation/dashboard_screen.dart';
import 'package:infinity_world/features/settings/presentation/settings_screen.dart';
import 'package:infinity_world/features/tools/presentation/tools_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    _ShellPlaceholderTab(title: 'Explore', icon: Icons.explore_rounded),
    ToolsScreen(),
    _ShellPlaceholderTab(title: 'Library', icon: Icons.local_library_rounded),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_rounded),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_library_rounded),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class _ShellPlaceholderTab extends StatelessWidget {
  const _ShellPlaceholderTab({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        top: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(IwSpacing.screenPadding),
            child: Icon(
              icon,
              size: IwSpacing.space48,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
