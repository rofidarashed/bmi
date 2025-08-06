import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/logic/calculator.dart';
import 'package:bmi/feature/bmi/screens/bmi_result_screen.dart';
import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({
    super.key,
    required this.weight,
    required this.height,
    required this.isMale,
  });

  final int weight;
  final double height;
  final bool isMale;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final calculator = BMICalculator(
              weight: weight.toDouble(),
              height: height / 100,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BMIResultScreen(
                  bmiValue: calculator.calculateBMI(),
                  resultText: calculator.getResultText(),
                  isMale: isMale,
                  weight: weight.toDouble(),
                  height: height / 100,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'CALCULATE BMI',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
