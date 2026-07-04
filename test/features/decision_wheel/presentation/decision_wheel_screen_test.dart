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
    expect(tester.takeException(), isNull);
  });

  testWidgets('Decision Wheel selects a deterministic option', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: DecisionWheelScreen(pickIndex: (_) => 1)),
    );

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    await tester.ensureVisible(find.text('Spin'));
    await tester.tap(find.text('Spin'));
    await tester.pump();

    expect(find.text('Selected option'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
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
