enum BmiCategory {
  underweight('Gầy'),
  normal('Bình thường'),
  overweight('Thừa cân'),
  obese('Béo phì');

  const BmiCategory(this.displayLabel);

  final String displayLabel;
}

double calculateBmi({required double heightCm, required double weightKg}) {
  if (heightCm <= 0) {
    throw ArgumentError.value(
      heightCm,
      'heightCm',
      'must be greater than zero',
    );
  }
  if (weightKg <= 0) {
    throw ArgumentError.value(
      weightKg,
      'weightKg',
      'must be greater than zero',
    );
  }

  final heightM = heightCm / 100;
  return weightKg / (heightM * heightM);
}

BmiCategory classifyBmi(double bmi) {
  if (bmi < 18.5) {
    return BmiCategory.underweight;
  }
  if (bmi < 25) {
    return BmiCategory.normal;
  }
  if (bmi < 30) {
    return BmiCategory.overweight;
  }
  return BmiCategory.obese;
}
