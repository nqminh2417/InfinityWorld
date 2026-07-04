import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/bmi/domain/bmi_calculator.dart';

void main() {
  group('calculateBmi', () {
    test(
      'calculates BMI from height in centimeters and weight in kilograms',
      () {
        final bmi = calculateBmi(heightCm: 170, weightKg: 65);

        expect(bmi, closeTo(22.491, 0.001));
      },
    );

    test('rejects a non-positive height', () {
      expect(
        () => calculateBmi(heightCm: 0, weightKg: 65),
        throwsArgumentError,
      );
    });

    test('rejects a non-positive weight', () {
      expect(
        () => calculateBmi(heightCm: 170, weightKg: 0),
        throwsArgumentError,
      );
    });
  });

  group('classifyBmi', () {
    test('uses the existing BMI classification boundaries', () {
      expect(classifyBmi(18.49), BmiCategory.underweight);
      expect(classifyBmi(18.5), BmiCategory.normal);
      expect(classifyBmi(24.99), BmiCategory.normal);
      expect(classifyBmi(25), BmiCategory.overweight);
      expect(classifyBmi(29.99), BmiCategory.overweight);
      expect(classifyBmi(30), BmiCategory.obese);
    });

    test('maps categories to the current Vietnamese labels', () {
      expect(BmiCategory.underweight.displayLabel, 'Gầy');
      expect(BmiCategory.normal.displayLabel, 'Bình thường');
      expect(BmiCategory.overweight.displayLabel, 'Thừa cân');
      expect(BmiCategory.obese.displayLabel, 'Béo phì');
    });
  });
}
