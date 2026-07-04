import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/design_system/components/iw_card.dart';
import 'package:infinity_world/features/unit_converter/presentation/unit_converter_screen.dart';

void main() {
  testWidgets('Unit Converter renders as a scroll-safe input screen', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MaterialApp(home: UnitConverterScreen()));
    await tester.pump();

    expect(find.text('Unit Converter'), findsOneWidget);
    expect(find.text('Convert units'), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SafeArea && !widget.top && widget.bottom,
      ),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Unit Converter converts length values', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UnitConverterScreen()));
    await tester.pump();

    await tester.enterText(find.byType(TextField), '1000');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.text('1000 m'), findsOneWidget);
    expect(find.text('1 km'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Unit Converter switches to weight units', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UnitConverterScreen()));
    await tester.pump();

    await tester.tap(find.text('Length'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Weight').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '2');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.text('2 kg'), findsOneWidget);
    expect(find.text('2000 g'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Unit Converter validates numeric input', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UnitConverterScreen()));
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'abc');
    await tester.tap(find.text('Convert'));
    await tester.pump();

    expect(find.text('Enter a valid number.'), findsOneWidget);
    expect(find.byType(IwCard), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
