import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/routes/app_routes.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(
              'External modules',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Open existing trackers and discovery modules without loading them on the tab.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(
              onTap: () => context.push(AppRoutes.fox),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.pets_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Random Fox'),
                subtitle: const Text(
                  'Browse a random fox image from the existing module.',
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
            const SizedBox(height: IwSpacing.space12),
            IwCard(
              onTap: () => context.push(AppRoutes.smtsHome),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.sports_esports_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Summertime Saga'),
                subtitle: const Text('Open the existing progress tracker.'),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
