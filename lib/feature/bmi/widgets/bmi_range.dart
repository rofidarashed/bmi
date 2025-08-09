import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/logic/bmi_gauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBMIRange extends StatelessWidget {
  const CustomBMIRange({
    super.key,
    required this.bmi,
    required this.resultColor,
    required this.slideAnimation,
  });
  final Animation<Offset> slideAnimation;
  final double bmi;
  final Color resultColor;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20.r,
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
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 20.h),
            buildBMIGauge(context, bmi: bmi, resultColor: resultColor),
          ],
        ),
      ),
    );
  }
}

