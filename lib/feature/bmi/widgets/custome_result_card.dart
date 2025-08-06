
import 'package:bmi/core/app_animations.dart';
import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/screens/bmi_result_screen.dart';
import 'package:flutter/material.dart';

class CustomeResultCard extends StatelessWidget {
  const CustomeResultCard({
    super.key,
    required this.resultColor,
    required this.widget,
  });

  final Color resultColor;
  final BMIResultScreen widget;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: AppAnimations.slideAnimation,
      child: ScaleTransition(
        scale: AppAnimations.scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: resultColor.withOpacity(0.2),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                widget.resultText.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  color: resultColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              Hero(
                tag: "bmi_value",
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          resultColor.withOpacity(0.2),
                          resultColor.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: resultColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      widget.bmiValue,
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: resultColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Body Mass Index',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
