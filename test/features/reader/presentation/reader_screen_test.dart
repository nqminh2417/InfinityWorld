import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/reader/application/reader_saved_sample_provider.dart';
import 'package:infinity_world/features/reader/presentation/reader_screen.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    SharedPreferencesAsyncPlatform.instance = null;
  });

  testWidgets('Reader screen renders a scroll-safe local reading sample', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ReaderScreen())),
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsOneWidget);
    expect(find.text('Reader'), findsOneWidget);
    expect(find.text('The First Door'), findsOneWidget);
    expect(find.text('InfinityWorld sample'), findsOneWidget);
    expect(find.textContaining('first door opened quietly'), findsOneWidget);
    expect(find.text('Save sample'), findsOneWidget);
    expect(find.byTooltip('Jump to bookmarked paragraph'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reader jumps to the bookmarked paragraph from the app bar', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await ReaderParagraphBookmarkRepository().bookmarkParagraph(
      'focus-reset',
      2,
    );

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ReaderScreen(sampleId: 'focus-reset')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byTooltip('Jump to bookmarked paragraph'), findsOneWidget);
    final scrollable = tester.state<ScrollableState>(find.byType(Scrollable));
    expect(scrollable.position.pixels, 0);

    await tester.tap(find.byTooltip('Jump to bookmarked paragraph'));
    await tester.pumpAndSettle();

    expect(scrollable.position.pixels, greaterThan(0));
    expect(find.text('Bookmarked paragraph 3'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reader screen saves and removes the built-in sample', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ReaderScreen())),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save sample'));
    await tester.pumpAndSettle();

    expect(find.text('Saved sample'), findsOneWidget);
    expect(find.text('Remove saved sample'), findsOneWidget);
    expect(await ReaderSavedSampleRepository().isSampleSaved(), isTrue);

    await tester.tap(find.text('Remove saved sample'));
    await tester.pumpAndSettle();

    expect(find.text('Save sample'), findsOneWidget);
    expect(await ReaderSavedSampleRepository().isSampleSaved(), isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reader screen saves and removes the selected local sample', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ReaderScreen(sampleId: 'focus-reset')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Focus Reset'), findsOneWidget);
    expect(find.text('Save sample'), findsOneWidget);

    await tester.tap(find.text('Save sample'));
    await tester.pumpAndSettle();

    expect(find.text('Saved sample'), findsOneWidget);
    expect(find.text('Remove saved sample'), findsOneWidget);
    expect(
      await ReaderSavedSampleRepository().isSampleSaved('focus-reset'),
      isTrue,
    );

    await tester.tap(find.text('Remove saved sample'));
    await tester.pumpAndSettle();

    expect(find.text('Save sample'), findsOneWidget);
    expect(
      await ReaderSavedSampleRepository().isSampleSaved('focus-reset'),
      isFalse,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reader screen marks and unmarks the selected local sample', (
    tester,
  ) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ReaderScreen(sampleId: 'focus-reset')),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Focus Reset'), findsOneWidget);
    expect(find.text('Mark finished'), findsOneWidget);

    await tester.tap(find.text('Mark finished'));
    await tester.pumpAndSettle();

    expect(find.text('Finished sample'), findsOneWidget);
    expect(find.text('Mark unfinished'), findsOneWidget);
    expect(
      await ReaderFinishedSampleRepository().isSampleFinished('focus-reset'),
      isTrue,
    );

    await tester.tap(find.text('Mark unfinished'));
    await tester.pumpAndSettle();

    expect(find.text('Mark finished'), findsOneWidget);
    expect(
      await ReaderFinishedSampleRepository().isSampleFinished('focus-reset'),
      isFalse,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Reader screen records the selected local sample as last opened',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(home: ReaderScreen(sampleId: 'focus-reset')),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        await ReaderLastOpenedSampleRepository().loadLastOpenedSampleId(),
        'focus-reset',
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Reader screen changes local sample text size', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: ReaderScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Text size'), findsOneWidget);

    final paragraphFinder = find.textContaining('first door opened quietly');
    Text paragraph = tester.widget(paragraphFinder);
    expect(paragraph.style?.fontSize, 17);

    await tester.tap(find.text('Large'));
    await tester.pump();

    paragraph = tester.widget(paragraphFinder);
    expect(paragraph.style?.fontSize, 20);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Reader screen stores one paragraph bookmark per sample', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 760));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: ReaderScreen(sampleId: 'focus-reset')),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Bookmark paragraph 2'), 240);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bookmark paragraph 2'));
    await tester.pumpAndSettle();

    expect(
      await ReaderParagraphBookmarkRepository().loadBookmarkForSample(
        'focus-reset',
      ),
      1,
    );
    expect(find.text('Bookmarked paragraph 2'), findsOneWidget);
    expect(find.text('Remove bookmark'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Bookmark paragraph 3'), 240);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bookmark paragraph 3'));
    await tester.pumpAndSettle();

    expect(
      await ReaderParagraphBookmarkRepository().loadBookmarkForSample(
        'focus-reset',
      ),
      2,
    );
    expect(find.text('Bookmarked paragraph 2'), findsNothing);
    expect(find.text('Bookmarked paragraph 3'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Remove bookmark'), -240);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Remove bookmark'));
    await tester.pumpAndSettle();

    expect(
      await ReaderParagraphBookmarkRepository().loadBookmarkForSample(
        'focus-reset',
      ),
      isNull,
    );
    expect(find.text('Bookmarked paragraph 3'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
