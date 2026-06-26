import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/test/presentation/test_screen.dart';

void main() {
  testWidgets('Test screen remains scroll-safe with keyboard inset', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(360, 640),
            viewInsets: EdgeInsets.only(bottom: 300),
          ),
          child: const TestScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SafeArea), findsWidgets);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(tester.takeException(), isNull);
  });
}
