import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_colors.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/reader/application/reader_saved_sample_provider.dart';
import 'package:infinity_world/features/reader/domain/reader_sample.dart';
import 'package:infinity_world/routes/app_routes.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final savedSampleIds = ref
        .watch(readerSavedSampleProvider)
        .when(
          data: (value) => value,
          error: (_, __) => <String>{},
          loading: () => <String>{},
        );
    final finishedSampleIds = ref
        .watch(readerFinishedSampleProvider)
        .when(
          data: (value) => value,
          error: (_, __) => <String>{},
          loading: () => <String>{},
        );
    final savedSamples = [
      for (final sample in readerSampleCatalog)
        if (savedSampleIds.contains(sample.id)) sample,
    ];
    final savedCount = savedSamples.length;
    final lastOpenedSample = ref
        .watch(readerLastOpenedSampleProvider)
        .when(
          data:
              (sampleId) =>
                  sampleId == null ? null : readerSampleById(sampleId),
          error: (_, __) => null,
          loading: () => null,
        );

    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(IwSpacing.screenPadding),
          children: [
            Text(
              'Saved content',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space8),
            Text(
              'A calm space for books, articles, and reading progress.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: IwColors.textSecondary(brightness),
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
            IwCard(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.collections_bookmark_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: IwSpacing.space12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          savedCount == 0
                              ? 'No saved content yet'
                              : '$savedCount saved sample${savedCount == 1 ? '' : 's'}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          _savedContentSummary(savedSamples),
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: IwColors.textSecondary(brightness),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (lastOpenedSample != null) ...[
              const SizedBox(height: IwSpacing.space20),
              Text(
                'Continue reading',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: IwSpacing.space12),
              _ReaderSampleCard(
                sample: lastOpenedSample,
                isSaved: savedSampleIds.contains(lastOpenedSample.id),
                isFinished: finishedSampleIds.contains(lastOpenedSample.id),
                description: 'Last opened local sample.',
              ),
            ],
            if (savedSamples.isNotEmpty) ...[
              const SizedBox(height: IwSpacing.space20),
              Text(
                'Saved samples',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: IwSpacing.space12),
              for (final sample in savedSamples) ...[
                _ReaderSampleCard(
                  sample: sample,
                  isSaved: true,
                  isFinished: finishedSampleIds.contains(sample.id),
                ),
                const SizedBox(height: IwSpacing.space12),
              ],
            ],
            const SizedBox(height: IwSpacing.space20),
            Text(
              'Local samples',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space12),
            for (final sample in readerSampleCatalog) ...[
              _ReaderSampleCard(
                sample: sample,
                isSaved: savedSampleIds.contains(sample.id),
                isFinished: finishedSampleIds.contains(sample.id),
              ),
              const SizedBox(height: IwSpacing.space12),
            ],
          ],
        ),
      ),
    );
  }
}

class _ReaderSampleCard extends StatelessWidget {
  const _ReaderSampleCard({
    required this.sample,
    required this.isSaved,
    required this.isFinished,
    this.description,
  });

  final ReaderSample sample;
  final bool isSaved;
  final bool isFinished;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final baseDescription =
        description ??
        (isSaved ? 'Saved locally. Continue this sample.' : sample.description);
    final sampleDescription =
        isFinished ? '$baseDescription Finished locally.' : baseDescription;

    return IwCard(
      onTap: () => context.push(_readerSampleRoute(sample.id)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: IwSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sample.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: IwSpacing.space4),
                Text(
                  sampleDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: IwColors.textSecondary(brightness),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: IwSpacing.space12),
          Icon(
            Icons.chevron_right_rounded,
            color: IwColors.textSecondary(brightness),
          ),
        ],
      ),
    );
  }
}

String _savedContentSummary(List<ReaderSample> savedSamples) {
  if (savedSamples.isEmpty) {
    return 'Saved reads and progress will appear here.';
  }
  if (savedSamples.length == 1) {
    return '${savedSamples.first.title} is saved locally.';
  }

  return 'Saved local samples are ready to continue.';
}

String _readerSampleRoute(String sampleId) {
  return Uri(
    path: AppRoutes.reader,
    queryParameters: {'sample': sampleId},
  ).toString();
}
