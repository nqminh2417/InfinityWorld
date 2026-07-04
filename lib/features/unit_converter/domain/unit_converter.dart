enum UnitConverterCategory { length, weight }

class UnitDefinition {
  final String id;
  final String label;
  final String symbol;
  final double toBaseFactor;

  const UnitDefinition({
    required this.id,
    required this.label,
    required this.symbol,
    required this.toBaseFactor,
  });
}

class UnitConverterSpec {
  final UnitConverterCategory category;
  final String label;
  final List<UnitDefinition> units;

  const UnitConverterSpec({
    required this.category,
    required this.label,
    required this.units,
  });
}

const unitConverterSpecs = <UnitConverterSpec>[
  UnitConverterSpec(
    category: UnitConverterCategory.length,
    label: 'Length',
    units: [
      UnitDefinition(id: 'meter', label: 'Meter', symbol: 'm', toBaseFactor: 1),
      UnitDefinition(
        id: 'kilometer',
        label: 'Kilometer',
        symbol: 'km',
        toBaseFactor: 1000,
      ),
      UnitDefinition(
        id: 'centimeter',
        label: 'Centimeter',
        symbol: 'cm',
        toBaseFactor: 0.01,
      ),
      UnitDefinition(
        id: 'foot',
        label: 'Foot',
        symbol: 'ft',
        toBaseFactor: 0.3048,
      ),
      UnitDefinition(
        id: 'inch',
        label: 'Inch',
        symbol: 'in',
        toBaseFactor: 0.0254,
      ),
    ],
  ),
  UnitConverterSpec(
    category: UnitConverterCategory.weight,
    label: 'Weight',
    units: [
      UnitDefinition(
        id: 'kilogram',
        label: 'Kilogram',
        symbol: 'kg',
        toBaseFactor: 1,
      ),
      UnitDefinition(
        id: 'gram',
        label: 'Gram',
        symbol: 'g',
        toBaseFactor: 0.001,
      ),
      UnitDefinition(
        id: 'pound',
        label: 'Pound',
        symbol: 'lb',
        toBaseFactor: 0.45359237,
      ),
      UnitDefinition(
        id: 'ounce',
        label: 'Ounce',
        symbol: 'oz',
        toBaseFactor: 0.028349523125,
      ),
    ],
  ),
];

UnitConverterSpec unitConverterSpecFor(UnitConverterCategory category) {
  return unitConverterSpecs.firstWhere((spec) => spec.category == category);
}

UnitDefinition unitConverterUnitById(
  UnitConverterCategory category,
  String unitId,
) {
  return unitConverterSpecFor(
    category,
  ).units.firstWhere((unit) => unit.id == unitId);
}

double convertUnit({
  required UnitConverterCategory category,
  required String fromUnitId,
  required String toUnitId,
  required double value,
}) {
  final fromUnit = unitConverterUnitById(category, fromUnitId);
  final toUnit = unitConverterUnitById(category, toUnitId);

  return value * fromUnit.toBaseFactor / toUnit.toBaseFactor;
}

String formatConvertedValue(double value) {
  if (value == 0) {
    return '0';
  }

  final absoluteValue = value.abs();
  if (absoluteValue >= 100000 || absoluteValue < 0.001) {
    return value.toStringAsExponential(4);
  }

  return value.toStringAsFixed(4).replaceFirst(RegExp(r'\.?0+$'), '');
}
