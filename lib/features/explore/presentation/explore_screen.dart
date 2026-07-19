import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_radius.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/app/router/app_routes.dart';

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
              'Discovery modules',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Browse existing external modules without loading live data on the tab.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            Text('Highlights', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: IwSpacing.space12),
            _ExploreModuleCard(
              icon: Icons.pets_rounded,
              title: 'Random Fox',
              category: 'Image discovery',
              description:
                  'Open a focused image module that fetches one random fox after you enter the screen.',
              badges: const ['External API', 'Loads after open'],
              onTap: () => context.push(AppRoutes.fox),
            ),
            const SizedBox(height: IwSpacing.space12),
            _ExploreModuleCard(
              icon: Icons.sports_esports_rounded,
              title: 'Summertime Saga',
              category: 'Progress tracker',
              description:
                  'Check the existing tracker module with loading, error, and retry states kept inside the destination.',
              badges: const ['Tracker', 'Loads after open'],
              onTap: () => context.push(AppRoutes.smtsHome),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreModuleCard extends StatelessWidget {
  const _ExploreModuleCard({
    required this.icon,
    required this.title,
    required this.category,
    required this.description,
    required this.badges,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String category;
  final String description;
  final List<String> badges;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);

    return IwCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(IwSpacing.space10),
            decoration: BoxDecoration(
              color: IwColors.surface2(brightness),
              borderRadius: BorderRadius.circular(IwRadius.radius12),
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: IwSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: secondaryText),
                ),
                const SizedBox(height: IwSpacing.space4),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: IwSpacing.space6),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: secondaryText),
                ),
                const SizedBox(height: IwSpacing.space12),
                Wrap(
                  spacing: IwSpacing.space8,
                  runSpacing: IwSpacing.space8,
                  children: [
                    for (final badge in badges) _ExploreBadge(label: badge),
                  ],
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

class _ExploreBadge extends StatelessWidget {
  const _ExploreBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: IwSpacing.space8,
        vertical: IwSpacing.space4,
      ),
      decoration: BoxDecoration(
        color: IwColors.surface2(brightness),
        borderRadius: BorderRadius.circular(IwRadius.radiusFull),
        border: Border.all(color: IwColors.border(brightness)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
