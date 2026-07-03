import 'package:flutter/material.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';

const _readerSampleParagraphs = <String>[
  'InfinityWorld sample: the first door opened quietly, not with a flash, but with the small certainty that a useful place had finally found its shape.',
  'Inside was a calm room of notes, stories, and saved ideas. Nothing asked to be synced, imported, ranked, or organized yet. It only needed to be readable.',
  'The reader will grow later when the Library earns persistence, bookmarks, and progress. For now, this sample proves the surface can hold text with the same care as the rest of the app.',
];

class ReaderScreen extends StatelessWidget {
  const ReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(height: 1.55);

    return Scaffold(
      appBar: AppBar(title: const Text('Reader')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(
              'The First Door',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'Local reading sample',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: secondaryText),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'InfinityWorld sample',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: IwSpacing.space12),
                  for (final paragraph in _readerSampleParagraphs) ...[
                    Text(paragraph, style: bodyStyle),
                    const SizedBox(height: IwSpacing.space16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
