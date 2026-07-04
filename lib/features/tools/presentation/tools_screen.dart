import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/routes/app_routes.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(title: const Text('Tools')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(
              'Utility modules',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Quick access to local tools already available in InfinityWorld.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(
              onTap: () => context.push(AppRoutes.bmi),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.monitor_weight_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BMI Calculator',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          'Estimate body mass index from height and weight.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: IwColors.textSecondary(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space12),
            IwCard(
              onTap: () => context.push(AppRoutes.clock),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clock',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          'View live device and California digital time.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: IwColors.textSecondary(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space12),
            IwCard(
              onTap: () => context.push(AppRoutes.randomPicker),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shuffle_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Random Picker',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          'Choose one item from a custom local list.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: IwColors.textSecondary(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space12),
            IwCard(
              onTap: () => context.push(AppRoutes.decisionWheel),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.casino_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Decision Wheel',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          'Spin a simple wheel to choose from local options.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: IwColors.textSecondary(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space12),
            IwCard(
              onTap: () => context.push(AppRoutes.unitConverter),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.straighten_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unit Converter',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          'Convert common length and weight units locally.',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: IwColors.textSecondary(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
