import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/design_system/tokens/iw_spacing.dart';
import 'package:infinity_world/features/library/presentation/library_screen.dart';
import 'package:infinity_world/features/reader/application/reader_saved_sample_provider.dart';
import 'package:infinity_world/features/reader/presentation/reader_screen.dart';
import 'package:infinity_world/main.dart';
import 'package:infinity_world/routes/app_routes.dart';
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

  testWidgets('Library screen is scroll-safe on small screens', (tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LibraryScreen())),
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(IwCard), findsWidgets);
    expect(find.text('Saved content'), findsOneWidget);
    expect(find.text('Continue reading'), findsNothing);
    expect(find.text('Saved samples'), findsNothing);
    expect(find.text('Local samples'), findsOneWidget);
    expect(find.text('The First Door'), findsOneWidget);
    expect(find.text('Focus Reset'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Night Market Notes'),
      IwSpacing.space64,
    );
    expect(find.text('Night Market Notes'), findsOneWidget);
    expect(
      find.text('Open and save the built-in local sample.'),
      findsOneWidget,
    );
    expect(find.text('No saved content yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library screen reflects a saved reader sample', (tester) async {
    await ReaderSavedSampleRepository().saveSample();

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LibraryScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Saved samples'), findsOneWidget);
    expect(find.text('The First Door'), findsNWidgets(2));
    expect(find.text('Saved locally. Continue this sample.'), findsNWidgets(2));
    expect(find.text('1 saved sample'), findsOneWidget);
    expect(find.text('The First Door is saved locally.'), findsOneWidget);
    expect(find.text('No saved content yet'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library screen reflects multiple saved local samples', (
    tester,
  ) async {
    final repository = ReaderSavedSampleRepository();
    await repository.saveSample('focus-reset');
    await repository.saveSample('night-market-notes');

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LibraryScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('2 saved samples'), findsOneWidget);
    expect(
      find.text('Saved local samples are ready to continue.'),
      findsOneWidget,
    );
    expect(find.text('Saved samples'), findsOneWidget);
    expect(find.text('Saved locally. Continue this sample.'), findsNWidgets(2));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library screen shows the last opened sample card', (
    tester,
  ) async {
    await ReaderLastOpenedSampleRepository().saveLastOpenedSampleId(
      'focus-reset',
    );

    await tester.pumpWidget(
      const ProviderScope(child: MaterialApp(home: LibraryScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Continue reading'), findsOneWidget);
    expect(find.text('Focus Reset'), findsWidgets);
    expect(find.text('Last opened local sample.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library saved sample shelf opens the selected Reader route', (
    tester,
  ) async {
    await ReaderSavedSampleRepository().saveSample('focus-reset');

    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.local_library_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Saved samples'), findsOneWidget);

    await tester.tap(find.text('Focus Reset').first);
    await tester.pumpAndSettle();

    expect(find.byType(ReaderScreen), findsOneWidget);
    expect(find.text('Focus Reset'), findsOneWidget);
    expect(find.textContaining('Close the noisy loops'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library continue reading card opens the selected Reader route', (
    tester,
  ) async {
    await ReaderLastOpenedSampleRepository().saveLastOpenedSampleId(
      'night-market-notes',
    );

    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.local_library_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Continue reading'), findsOneWidget);

    await tester.tap(find.text('Night Market Notes').first);
    await tester.pumpAndSettle();

    expect(find.byType(ReaderScreen), findsOneWidget);
    expect(find.text('Night Market Notes'), findsOneWidget);
    expect(find.textContaining('The night market opened'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Library sample card opens the selected Reader route', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: MainApp(initialRoute: AppRoutes.main)),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.local_library_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(LibraryScreen), findsOneWidget);

    await tester.tap(find.text('Focus Reset'));
    await tester.pumpAndSettle();

    expect(find.byType(ReaderScreen), findsOneWidget);
    expect(find.text('Focus Reset'), findsOneWidget);
    expect(find.textContaining('Close the noisy loops'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
