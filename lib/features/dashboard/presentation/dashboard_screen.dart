import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/auth/application/session_providers.dart';
import 'package:infinity_world/app/router/app_routes.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isLoggingOut = false;

  Future<void> _logout() async {
    if (_isLoggingOut) {
      return;
    }

    _isLoggingOut = true;
    try {
      await ref.read(localSessionRepositoryProvider).clearSession();
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
    final displayName = ref.watch(currentDisplayNameProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            IwCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName.when(
                      data:
                          (value) =>
                              value == null
                                  ? 'Welcome back'
                                  : 'Welcome back, $value',
                      error: (_, __) => 'Welcome back',
                      loading: () => 'Loading your local profile...',
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: IwSpacing.space8),
                  Text(
                    'Your local InfinityWorld hub.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: IwColors.textSecondary(brightness),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.logout_rounded,
              title: 'Log out',
              subtitle: 'Return to local profile entry.',
              iconColor: IwColors.error(brightness),
              onTap: _logout,
            ),
            const SizedBox(height: IwSpacing.sectionGap),
            Text(
              'Quick actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.monitor_weight_rounded,
              title: 'BMI Calculator',
              subtitle: 'Body index estimate.',
              onTap: () => context.push(AppRoutes.bmi),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.schedule_rounded,
              title: 'Clock',
              subtitle: 'Local and California time.',
              onTap: () => context.push(AppRoutes.clock),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.shuffle_rounded,
              title: 'Random Picker',
              subtitle: 'One-choice decision helper.',
              onTap: () => context.push(AppRoutes.randomPicker),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.casino_rounded,
              title: 'Decision Wheel',
              subtitle: 'Spin a simple wheel to choose from local options.',
              onTap: () => context.push(AppRoutes.decisionWheel),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.straighten_rounded,
              title: 'Unit Converter',
              subtitle: 'Convert common length and weight units locally.',
              onTap: () => context.push(AppRoutes.unitConverter),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.pets_rounded,
              title: 'Random Fox',
              subtitle: 'Random image module.',
              onTap: () => context.push(AppRoutes.fox),
            ),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.sports_esports_rounded,
              title: 'Summertime Saga',
              subtitle: 'Progress tracker.',
              onTap: () => context.push(AppRoutes.smtsHome),
            ),
            const SizedBox(height: IwSpacing.sectionGap),
            Text('Developer', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: IwSpacing.space12),
            _DashboardActionCard(
              icon: Icons.science_rounded,
              title: 'Test Screen',
              subtitle: 'Internal form and lifecycle check.',
              onTap: () => context.push(AppRoutes.test),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;

  const _DashboardActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);

    return IwCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.primary),
          const SizedBox(width: IwSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: IwSpacing.space4),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: secondaryText),
                ),
              ],
            ),
          ),
          const SizedBox(width: IwSpacing.space12),
          Icon(Icons.chevron_right_rounded, color: secondaryText),
        ],
      ),
    );
  }
}
