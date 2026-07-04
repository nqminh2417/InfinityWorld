import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/clock/presentation/clock_screen.dart';

void main() {
  testWidgets('Clock screen shows local and California digital times', (
    tester,
  ) async {
    var now = DateTime.utc(2026, 7, 3, 16, 8, 7);

    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(MaterialApp(home: ClockScreen(now: () => now)));
    await tester.pump();

    expect(find.text('Clock'), findsOneWidget);
    expect(find.text('Device local current time'), findsOneWidget);
    expect(find.byType(AnalogClockFace), findsOneWidget);
    expect(find.text('16:08:07'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    expect(find.text('California current time'), findsOneWidget);
    expect(find.text('09:08:07'), findsOneWidget);

    now = now.add(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('09:08:08'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pumpAndSettle();

    expect(find.text('16:08:08'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Clock screen disposes its ticker safely', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ClockScreen(now: () => DateTime.utc(2026, 7, 3, 16, 8, 7)),
      ),
    );
    await tester.pump();

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 2));

    expect(tester.takeException(), isNull);
  });
}
