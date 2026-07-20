import 'dart:async';

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
  final _bookmarkedParagraphKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _recordOpenedSample();
  }

  @override
  void didUpdateWidget(covariant ReaderScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sampleId != widget.sampleId) {
      _recordOpenedSample();
    }
  }

  void _recordOpenedSample() {
    final sample = readerSampleById(widget.sampleId);
    unawaited(
      ref.read(readerLastOpenedSampleProvider.notifier).recordSample(sample.id),
    );
  }

  void _jumpToBookmarkedParagraph() {
    final targetContext = _bookmarkedParagraphKey.currentContext;
    if (targetContext == null) {
      return;
    }

    unawaited(
      Scrollable.ensureVisible(
        targetContext,
        alignment: 0.12,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sample = readerSampleById(widget.sampleId);
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);
    final savedSampleIds = ref.watch(readerSavedSampleProvider);
    final finishedSampleIds = ref.watch(readerFinishedSampleProvider);
    final paragraphBookmarks = ref.watch(readerParagraphBookmarkProvider);
    final bookmarkedParagraphIndex = paragraphBookmarks.when(
      data: (bookmarks) => bookmarks[sample.id],
      error: (_, __) => null,
      loading: () => null,
    );
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontSize: _textSize.fontSize, height: 1.55);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reader'),
        actions: [
          if (bookmarkedParagraphIndex != null)
            IconButton(
              onPressed: _jumpToBookmarkedParagraph,
              icon: const Icon(Icons.my_location_rounded),
              tooltip: 'Jump to bookmarked paragraph',
            ),
        ],
      ),
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
            finishedSampleIds.when(
              data:
                  (finishedIds) => _ReaderFinishedSampleAction(
                    isFinished: finishedIds.contains(sample.id),
                    onPressed: () async {
                      final controller = ref.read(
                        readerFinishedSampleProvider.notifier,
                      );
                      if (finishedIds.contains(sample.id)) {
                        await controller.markUnfinished(sample.id);
                      } else {
                        await controller.markFinished(sample.id);
                      }
                    },
                  ),
              error:
                  (_, __) => Text(
                    'Progress state unavailable',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: secondaryText),
                  ),
              loading:
                  () => OutlinedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.task_alt_rounded),
                    label: const Text('Loading progress state'),
                  ),
            ),
            const SizedBox(height: IwSpacing.space16),
            paragraphBookmarks.when(
              data:
                  (bookmarks) => _ReaderContentCard(
                    sample: sample,
                    bodyStyle: bodyStyle,
                    bookmarkedParagraphIndex: bookmarks[sample.id],
                    bookmarkedParagraphKey: _bookmarkedParagraphKey,
                    onBookmarkPressed: (paragraphIndex) async {
                      final controller = ref.read(
                        readerParagraphBookmarkProvider.notifier,
                      );
                      if (bookmarks[sample.id] == paragraphIndex) {
                        await controller.removeBookmark(sample.id);
                      } else {
                        await controller.bookmarkParagraph(
                          sample.id,
                          paragraphIndex,
                        );
                      }
                    },
                  ),
              error:
                  (_, __) => _ReaderContentCard(
                    sample: sample,
                    bodyStyle: bodyStyle,
                    bookmarkStateLabel: 'Bookmark state unavailable',
                  ),
              loading:
                  () => _ReaderContentCard(
                    sample: sample,
                    bodyStyle: bodyStyle,
                    bookmarkStateLabel: 'Loading bookmarks',
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReaderContentCard extends StatelessWidget {
  const _ReaderContentCard({
    required this.sample,
    required this.bodyStyle,
    this.bookmarkedParagraphIndex,
    this.bookmarkedParagraphKey,
    this.onBookmarkPressed,
    this.bookmarkStateLabel,
  });

  final ReaderSample sample;
  final TextStyle? bodyStyle;
  final int? bookmarkedParagraphIndex;
  final Key? bookmarkedParagraphKey;
  final Future<void> Function(int paragraphIndex)? onBookmarkPressed;
  final String? bookmarkStateLabel;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);

    return IwCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sample.sectionTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (bookmarkStateLabel != null) ...[
            const SizedBox(height: IwSpacing.space4),
            Text(
              bookmarkStateLabel!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: secondaryText),
            ),
          ],
          const SizedBox(height: IwSpacing.space12),
          for (final paragraphEntry in sample.paragraphs.asMap().entries) ...[
            KeyedSubtree(
              key:
                  bookmarkedParagraphIndex == paragraphEntry.key
                      ? bookmarkedParagraphKey
                      : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(paragraphEntry.value, style: bodyStyle),
                  const SizedBox(height: IwSpacing.space8),
                  _ReaderParagraphBookmarkAction(
                    paragraphNumber: paragraphEntry.key + 1,
                    isBookmarked:
                        bookmarkedParagraphIndex == paragraphEntry.key,
                    onPressed:
                        onBookmarkPressed == null
                            ? null
                            : () => onBookmarkPressed!(paragraphEntry.key),
                  ),
                ],
              ),
            ),
            const SizedBox(height: IwSpacing.space16),
          ],
        ],
      ),
    );
  }
}

class _ReaderParagraphBookmarkAction extends StatelessWidget {
  const _ReaderParagraphBookmarkAction({
    required this.paragraphNumber,
    required this.isBookmarked,
    required this.onPressed,
  });

  final int paragraphNumber;
  final bool isBookmarked;
  final Future<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isBookmarked) ...[
          Text(
            'Bookmarked paragraph $paragraphNumber',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: secondaryText),
          ),
          const SizedBox(height: IwSpacing.space4),
        ],
        if (isBookmarked)
          OutlinedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.bookmark_remove_rounded),
            label: const Text('Remove bookmark'),
          )
        else
          TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.bookmark_add_outlined),
            label: Text('Bookmark paragraph $paragraphNumber'),
          ),
      ],
    );
  }
}

class _ReaderFinishedSampleAction extends StatelessWidget {
  const _ReaderFinishedSampleAction({
    required this.isFinished,
    required this.onPressed,
  });

  final bool isFinished;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final secondaryText = IwColors.textSecondary(brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isFinished ? 'Finished sample' : 'Not finished yet',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: secondaryText),
        ),
        const SizedBox(height: IwSpacing.space8),
        if (isFinished)
          OutlinedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.undo_rounded),
            label: const Text('Mark unfinished'),
          )
        else
          OutlinedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.task_alt_rounded),
            label: const Text('Mark finished'),
          ),
      ],
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
