import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Profile Screen'),
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(IwSpacing.screenPadding),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: IwCard(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      IwColors.primary,
                                      IwColors.primaryBright,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: IwSpacing.space16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Local Profile',
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                    ),
                                    const SizedBox(height: IwSpacing.space4),
                                    Text(
                                      'InfinityWorld',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color: IwColors.textSecondary(
                                          brightness,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: IwSpacing.space20),
                          Divider(color: IwColors.border(brightness)),
                          const SizedBox(height: IwSpacing.space12),
                          Text(
                            'Midnight Violet',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: IwSpacing.space4),
                          Text(
                            'System theme',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: IwColors.textSecondary(brightness),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
