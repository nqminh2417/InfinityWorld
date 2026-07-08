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
}
