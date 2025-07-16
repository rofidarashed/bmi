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
}
