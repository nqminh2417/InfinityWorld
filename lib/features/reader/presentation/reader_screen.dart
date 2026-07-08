import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/reader/application/reader_saved_sample_provider.dart';
import 'package:infinity_world/features/reader/domain/reader_sample.dart';

enum _ReaderTextSize {
  small('Small', 15),
  comfort('Comfort', 17),
  large('Large', 20);

  const _ReaderTextSize(this.label, this.fontSize);

  final String label;
  final double fontSize;
}

class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key, this.sampleId});

  final String? sampleId;

  @override
  ConsumerState<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen> {
  _ReaderTextSize _textSize = _ReaderTextSize.comfort;

  @override
  Widget build(BuildContext context) {
    final sample = readerSampleById(widget.sampleId);
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);
    final savedSampleIds = ref.watch(readerSavedSampleProvider);
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontSize: _textSize.fontSize, height: 1.55);

    return Scaffold(
      appBar: AppBar(title: const Text('Reader')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(sample.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: IwSpacing.space8),
            Text(
              sample.subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: secondaryText),
            ),
            const SizedBox(height: IwSpacing.space16),
            Text('Text size', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: IwSpacing.space8),
            SegmentedButton<_ReaderTextSize>(
              showSelectedIcon: false,
              segments: [
                for (final value in _ReaderTextSize.values)
                  ButtonSegment<_ReaderTextSize>(
                    value: value,
                    label: Text(value.label),
                  ),
              ],
              selected: {_textSize},
              onSelectionChanged: (selection) {
                setState(() {
                  _textSize = selection.first;
                });
              },
            ),
            const SizedBox(height: IwSpacing.space16),
            savedSampleIds.when(
              data:
                  (savedIds) => _ReaderSavedSampleAction(
                    isSaved: savedIds.contains(sample.id),
                    onPressed: () async {
                      final controller = ref.read(
                        readerSavedSampleProvider.notifier,
                      );
                      if (savedIds.contains(sample.id)) {
                        await controller.removeSample(sample.id);
                      } else {
                        await controller.saveSample(sample.id);
                      }
                    },
                  ),
              error:
                  (_, __) => Text(
                    'Saved state unavailable',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: secondaryText),
                  ),
              loading:
                  () => OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.bookmark_outline_rounded),
                    label: const Text('Loading saved state'),
                  ),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sample.sectionTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: IwSpacing.space12),
                  for (final paragraph in sample.paragraphs) ...[
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

class _ReaderSavedSampleAction extends StatelessWidget {
  const _ReaderSavedSampleAction({
    required this.isSaved,
    required this.onPressed,
  });

  final bool isSaved;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isSaved ? 'Saved sample' : 'Not saved yet',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: secondaryText),
        ),
        const SizedBox(height: IwSpacing.space8),
        if (isSaved)
          OutlinedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.bookmark_remove_rounded),
            label: const Text('Remove saved sample'),
          )
        else
          FilledButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.bookmark_add_rounded),
            label: const Text('Save sample'),
          ),
      ],
    );
  }
}
