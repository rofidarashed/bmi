import 'package:bmi/core/app_animations.dart';
import 'package:bmi/core/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBMIRange extends StatelessWidget {
  const CustomBMIRange({super.key, required this.bmi, required this.resultColor});
  final double bmi;
  final Color resultColor;
Widget _buildBMIGauge(context) {
  const double minBMI = 15;
  const double maxBMI = 35;
  double normalizedBMI = ((bmi - minBMI) / (maxBMI - minBMI)).clamp(0.0, 1.0);

  return Container(
    height: 120,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF74B9FF), // Underweight - Blue
                    Color(0xFF00CEC9), // Normal - Teal
                    Color(0xFFFDCB6E), // Overweight - Yellow
                    Color(0xFFE17055), // Obese - Orange/Red
                  ],
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: resultColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOutCubic,
              left: normalizedBMI * (MediaQuery.of(context).size.width - 140),
              top: -10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: resultColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: resultColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(Icons.place, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBMIRangeLabel("15", "Underweight"),
            _buildBMIRangeLabel("18.5", "Normal"),
            _buildBMIRangeLabel("25", "Overweight"),
            _buildBMIRangeLabel("30", "Obese"),
            _buildBMIRangeLabel("35", "Severe"),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBMIRangeLabel(String value, String label) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
      if (label.isNotEmpty) ...[
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: AppAnimations.slideAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BMI Range',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            _buildBMIGauge(context),
          ],
        ),
      ),
    );
  }
}

