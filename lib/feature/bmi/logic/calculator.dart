class BMICalculator {
  final double weight;
  final double height;

  BMICalculator({required this.weight, required this.height});

  String calculateBMI() {
    final result = weight / (height * height);
    return result.toStringAsFixed(1);
  }

  String getResultText() {
    final result = weight / (height * height);
    if (result < 15) return 'Very severely underweight';
    if (result < 16) return 'Severely underweight';
    if (result < 18.5) return 'Underweight';
    if (result < 25) return 'Normal';
    if (result < 30) return 'Overweight';
    if (result < 35) return 'Moderately obese';
    if (result < 40) return 'Severely obese';
    return 'Very severely obese';
  }

 static String getWeightAdjustmentAdvice(double weight, double height) {
  final minHealthy = 18.5 * height * height;
  final maxHealthy = 24.9 * height * height;

  if (weight < minHealthy) {
    final toGain = minHealthy - weight;
    return 'You should gain about ${toGain.toStringAsFixed(1)} kg to reach a healthy BMI.';
  } else if (weight > maxHealthy) {
    final toLose = weight - maxHealthy;
    return 'You should lose about ${toLose.toStringAsFixed(1)} kg to reach a healthy BMI.';
  } else {
    return 'You are already in the healthy weight range.';
  }
}

}
