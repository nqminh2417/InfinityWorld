import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/random_picker/presentation/random_picker_screen.dart';

void main() {
  testWidgets('Random Picker renders as a scroll-safe input screen', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(home: RandomPickerScreen(pickIndex: (_) => 1)),
    );
    await tester.pump();

    expect(find.text('Random Picker'), findsOneWidget);
    expect(find.text('Pick from a list'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Random Picker picks a deterministic option', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: RandomPickerScreen(pickIndex: (_) => 1)),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Alpha\nBeta\nGamma');
    await tester.tap(find.text('Pick one'));
    await tester.pump();

    expect(find.text('Selected option'), findsOneWidget);
    expect(find.text('Beta'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Random Picker validates that at least two options exist', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: RandomPickerScreen(pickIndex: (_) => 0)),
    );
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'Only one');
    await tester.tap(find.text('Pick one'));
    await tester.pump();

    expect(find.text('Add at least two options.'), findsOneWidget);
    expect(find.text('Selected option'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
