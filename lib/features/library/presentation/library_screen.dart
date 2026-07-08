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
    final isSampleSaved = ref
        .watch(readerSavedSampleProvider)
        .when(
          data: (value) => value,
          error: (_, __) => false,
          loading: () => false,
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
                          isSampleSaved
                              ? '1 saved sample'
                              : 'No saved content yet',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: IwSpacing.space4),
                        Text(
                          isSampleSaved
                              ? 'The First Door is saved locally.'
                              : 'Saved reads and progress will appear here.',
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
            const SizedBox(height: IwSpacing.space20),
            Text(
              'Local samples',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: IwSpacing.space12),
            for (final sample in readerSampleCatalog) ...[
              _ReaderSampleCard(
                sample: sample,
                isSaved: sample.canBeSaved && isSampleSaved,
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
  const _ReaderSampleCard({required this.sample, required this.isSaved});

  final ReaderSample sample;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final sampleDescription =
        isSaved
            ? 'Saved locally. Continue the built-in sample.'
            : sample.description;

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

String _readerSampleRoute(String sampleId) {
  return Uri(
    path: AppRoutes.reader,
    queryParameters: {'sample': sampleId},
  ).toString();
}
