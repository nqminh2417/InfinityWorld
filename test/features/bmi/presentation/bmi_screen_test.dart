import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/bmi/presentation/bmi_screen.dart';

void main() {
  testWidgets('BMI screen remains scroll-safe with keyboard inset', (
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
          child: const BmiScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('BMI screen calculates from the keyboard done action', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: BmiScreen()));

    await tester.enterText(find.byType(TextField).at(0), '170');
    await tester.enterText(find.byType(TextField).at(1), '65');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.text('BMI: 22.5'), findsOneWidget);
    expect(find.text('Bình thường'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
