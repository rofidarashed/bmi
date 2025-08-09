import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/logic/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HealthAdvice extends StatelessWidget {
  const HealthAdvice({
    super.key,
    required this.isMale,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.slideAnimation,
  });
  final double weight;
  final double height;
  final bool isMale;
  final double bmi;

  String get healthAdvice {
    if (bmi < 18.5) {
      return isMale
          ? "You're underweight. Consider increasing your protein and calorie intake along with strength training."
          : "You're underweight. A nutritionist can help you plan a healthy weight gain strategy.";
    }
    if (bmi < 25) {
      return isMale
          ? "You're in a healthy weight range. Keep it up with regular workouts and good nutrition."
          : "You're within a healthy BMI range. Maintain a balanced diet and regular exercise!";
    }
    if (bmi < 30) {
      return isMale
          ? "You're slightly overweight. Consider cutting back on processed foods and increasing activity levels."
          : "You're overweight. A combination of cardio, strength training, and a clean diet can help.";
    }
    return isMale
        ? "You're in the obese range. It's recommended to consult a healthcare provider to avoid heart and metabolic risks."
        : "You're in the obese range. Consider professional guidance for managing weight and hormonal balance.";
  }

  final Animation<Offset> slideAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isMale
                ? [
                    AppColors.malePrimary.withOpacity(0.1),
                    AppColors.maleSecondary.withOpacity(0.1),
                  ]
                : [
                    AppColors.femalePrimary.withOpacity(0.1),
                    AppColors.femaleSecondary.withOpacity(0.1),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isMale
                ? AppColors.malePrimary.withOpacity(0.2)
                : AppColors.femalePrimary.withOpacity(0.2),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: isMale
                        ? AppColors.malePrimary.withOpacity(0.2)
                        : AppColors.femalePrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.health_and_safety,
                    color: isMale
                        ? AppColors.malePrimary
                        : AppColors.femalePrimary,
                    size: 24,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Health Advice',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              healthAdvice,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textSecondary,
                height: 1.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 12.h),

            Text(
              BMICalculator.getWeightAdjustmentAdvice(weight, height),
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.textSecondary,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
