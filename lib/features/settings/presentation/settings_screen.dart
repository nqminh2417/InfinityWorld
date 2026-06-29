import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/app/theme/app_theme_mode_provider.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/auth/application/session_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final displayName = ref.watch(currentDisplayNameProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
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
                    'Local profile',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: IwSpacing.space8),
                  Text(
                    displayName.when(
                      data: (value) => value ?? 'InfinityWorld',
                      error: (_, __) => 'InfinityWorld',
                      loading: () => 'Loading profile...',
                    ),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: IwColors.textSecondary(brightness),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appearance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: IwSpacing.space8),
                  Text(
                    'Theme mode',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: IwSpacing.space4),
                  Text(
                    _themeModeLabel(themeMode),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: IwColors.textSecondary(brightness),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _themeModeLabel(ThemeMode themeMode) {
  return switch (themeMode) {
    ThemeMode.system => 'System',
    ThemeMode.light => 'Light',
    ThemeMode.dark => 'Dark',
  };
}
