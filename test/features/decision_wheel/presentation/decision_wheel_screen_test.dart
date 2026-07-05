import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/decision_wheel/presentation/decision_wheel_screen.dart';

void main() {
  testWidgets('Decision Wheel screen is scroll-safe on small screens', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );
    await tester.pump();

    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(DecisionWheelFace), findsOneWidget);
    expect(find.text('Spin a decision'), findsOneWidget);
    expect(find.text('Shuffle'), findsOneWidget);
    expect(find.text('Sort'), findsOneWidget);
    expect(find.text('History'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Spin'), findsNothing);

    final longEntries = List.generate(
      24,
      (index) => 'Option $index',
    ).join('\n');
    await tester.enterText(find.byType(TextField), longEntries);
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel center spin shows result dialog', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('decision-wheel-result-dialog')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('decision-wheel-entries-card')),
      findsOneWidget,
    );
    expect(find.text('Entries'), findsOneWidget);
    expect(find.text('Selected option'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel result dialog blocks background interaction', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Gamma\nAlpha\nBeta');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);

    await tester.tap(find.text('Sort'), warnIfMissed: false);
    await tester.pump();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Gamma\nAlpha\nBeta');
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel cancel closes dialog without changing entries', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Alpha\nBeta\nGamma');
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel remove deletes the selected option', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha; Beta ; Gamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Alpha\nGamma');
    expect(find.text('Selected option'), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel history shows completed spins', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    final historyButton = find.widgetWithText(OutlinedButton, 'History');
    await tester.ensureVisible(historyButton);
    await tester.pump();
    await tester.tap(historyButton);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('decision-wheel-history-sheet')),
      findsOneWidget,
    );
    expect(find.text('Spin #1'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
    expect(find.text('Clear history'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel history item copies selected option', (
    tester,
  ) async {
    final clipboardCalls = <MethodCall>[];
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      clipboardCalls.add(call);
      return null;
    });
    addTearDown(() {
      messenger.setMockMethodCallHandler(SystemChannels.platform, null);
    });

    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    final historyButton = find.widgetWithText(OutlinedButton, 'History');
    await tester.ensureVisible(historyButton);
    await tester.pump();
    await tester.tap(historyButton);
    await tester.pumpAndSettle();

    expect(find.text('Beta'), findsOneWidget);
    expect(find.text('Spin #1'), findsOneWidget);

    final copyButton = find.byTooltip('Copy result');
    expect(copyButton, findsOneWidget);
    await tester.tap(copyButton);
    await tester.pump();

    expect(
      clipboardCalls.any(
        (call) =>
            call.method == 'Clipboard.setData' &&
            (call.arguments as Map<Object?, Object?>)['text'] == 'Beta',
      ),
      isTrue,
    );
    expect(find.text('Copied to clipboard'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel empty history sheet wraps compact content', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );
    await tester.pump();

    final historyButton = find.widgetWithText(OutlinedButton, 'History');
    await tester.ensureVisible(historyButton);
    await tester.pump();
    await tester.tap(historyButton);
    await tester.pumpAndSettle();

    final sheetSize = tester.getSize(
      find.byKey(const ValueKey('decision-wheel-history-sheet')),
    );
    expect(sheetSize.height, lessThan(320));
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('decision-wheel-history-sheet')),
        matching: find.text('History'),
      ),
      findsOneWidget,
    );
    expect(find.text('No spins yet'), findsOneWidget);
    expect(find.text('Clear history'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel long history sheet caps and scrolls list', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    var nextPick = -1;
    await tester.pumpWidget(
      MaterialApp(
        home: DecisionWheelScreen(
          pickIndex: (optionCount) {
            nextPick = (nextPick + 1) % optionCount;
            return nextPick;
          },
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );

    for (var spin = 0; spin < 8; spin += 1) {
      await tester.ensureVisible(spinButton);
      await tester.pump();
      await tester.tap(spinButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    }

    final historyButton = find.widgetWithText(OutlinedButton, 'History');
    await tester.ensureVisible(historyButton);
    await tester.pump();
    await tester.tap(historyButton);
    await tester.pumpAndSettle();

    final longSheetHeight =
        tester
            .getSize(find.byKey(const ValueKey('decision-wheel-history-sheet')))
            .height;
    expect(longSheetHeight, lessThanOrEqualTo(352));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Spin #8'), findsOneWidget);
    expect(find.text('Clear history'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();

    expect(find.text('Spin #1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel history sheet grows with short history', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    var nextPick = -1;
    await tester.pumpWidget(
      MaterialApp(
        home: DecisionWheelScreen(
          pickIndex: (optionCount) {
            nextPick = (nextPick + 1) % optionCount;
            return nextPick;
          },
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );

    for (var spin = 0; spin < 6; spin += 1) {
      await tester.ensureVisible(spinButton);
      await tester.pump();
      await tester.tap(spinButton);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    }

    final historyButton = find.widgetWithText(OutlinedButton, 'History');
    await tester.ensureVisible(historyButton);
    await tester.pump();
    await tester.tap(historyButton);
    await tester.pumpAndSettle();

    final sheetHeight =
        tester
            .getSize(find.byKey(const ValueKey('decision-wheel-history-sheet')))
            .height;
    expect(find.text('Spin #6'), findsOneWidget);
    expect(sheetHeight, greaterThan(330));
    expect(sheetHeight, lessThanOrEqualTo(440));
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Clear history'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel clear history empties the list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'History'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear history'));
    await tester.pump();

    expect(find.text('No spins yet'), findsOneWidget);
    expect(find.text('Beta'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel remove keeps past history item', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(OutlinedButton, 'History'));
    await tester.pumpAndSettle();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Alpha\nGamma');
    expect(find.text('Spin #1'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel parses mixed lines and semicolons', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 3)),
    );

    await tester.enterText(
      find.byType(TextField),
      'Alpha; Beta\nGamma; ; Delta',
    );
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Delta'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel shuffle and sort update entries', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DecisionWheelScreen(
          pickIndex: (_) => 0,
          shuffleOptions: (options) => options.reversed.toList(growable: false),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Gamma\nAlpha\nBeta');
    await tester.ensureVisible(find.text('Sort'));
    await tester.tap(find.text('Sort'));
    await tester.pump();

    var field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Alpha\nBeta\nGamma');

    await tester.ensureVisible(find.text('Shuffle'));
    await tester.tap(find.text('Shuffle'));
    await tester.pump();

    field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Gamma\nBeta\nAlpha');
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel validates at least two options', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 0)),
    );

    await tester.enterText(find.byType(TextField), 'Only one');
    final spinButton = find.byKey(
      const ValueKey('decision-wheel-center-spin-button'),
    );
    await tester.ensureVisible(spinButton);
    await tester.pump();
    await tester.tap(spinButton);
    await tester.pump();

    expect(find.text('Add at least two options.'), findsOneWidget);
    expect(find.text('Selected option'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  test('Decision Wheel segment colors avoid adjacent duplicates', () {
    for (final optionCount in [2, 3, 6, 7, 8, 12, 13, 19]) {
      final colors = List.generate(
        optionCount,
        (index) => decisionWheelSegmentColor(index, optionCount),
      );

      for (var index = 0; index < colors.length; index += 1) {
        final nextColor = colors[(index + 1) % colors.length];
        expect(
          colors[index],
          isNot(nextColor),
          reason: 'optionCount=$optionCount index=$index',
        );
      }
    }
  });
}
