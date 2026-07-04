import 'package:flutter_test/flutter_test.dart';
import 'package:infinity_world/features/unit_converter/domain/unit_converter.dart';

void main() {
  test('converts meters to kilometers', () {
    final result = convertUnit(
      category: UnitConverterCategory.length,
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
      value: 1000,
    );

    expect(result, 1);
  });

  test('converts pounds to kilograms', () {
    final result = convertUnit(
      category: UnitConverterCategory.weight,
      fromUnitId: 'pound',
      toUnitId: 'kilogram',
      value: 2.2046226218,
    );

    expect(result, closeTo(1, 0.000001));
  });

  test('formats converted values without unnecessary trailing zeroes', () {
    expect(formatConvertedValue(1), '1');
    expect(formatConvertedValue(12.5), '12.5');
    expect(formatConvertedValue(0.00025), '2.5000e-4');
  });
}
