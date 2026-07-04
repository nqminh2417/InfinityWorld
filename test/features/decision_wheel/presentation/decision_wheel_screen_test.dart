import 'package:flutter/material.dart';
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
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel shows the selected option after spinning', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    await tester.ensureVisible(find.text('Spin'));
    await tester.tap(find.text('Spin'));
    await tester.pumpAndSettle();

    expect(find.text('Selected option'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Remove'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel remove deletes the selected option', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    await tester.ensureVisible(find.text('Spin'));
    await tester.tap(find.text('Spin'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Remove'));
    await tester.pump();

    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.controller?.text, 'Alpha\nGamma');
    expect(find.text('Selected option'), findsNothing);
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
    await tester.ensureVisible(find.text('Spin'));
    await tester.tap(find.text('Spin'));
    await tester.pump();

    expect(find.text('Add at least two options.'), findsOneWidget);
    expect(find.text('Selected option'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
