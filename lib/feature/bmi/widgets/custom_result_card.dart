import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/screens/bmi_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeResultCard extends StatelessWidget {
  const CustomeResultCard({
    super.key,
    required this.resultColor,
    required this.widget,
    required this.slideAnimation,
    required this.scaleAnimation,
  });

  final Color resultColor;
  final BMIResultScreen widget;
  final Animation<Offset> slideAnimation;
  final Animation<double> scaleAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32.w),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: resultColor.withOpacity(0.2),
                blurRadius: 30.r,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                widget.resultText.toUpperCase(),
                style: TextStyle(
                  fontSize: 18.sp,
                  color: resultColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 20.h),
              Hero(
                tag: "bmi_value",
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
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
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: resultColor.withOpacity(0.3),
                        width: 1.w,
                      ),
                    ),
                    child: Text(
                      widget.bmiValue,
                      style: TextStyle(
                        fontSize: 64.sp,
                        fontWeight: FontWeight.bold,
                        color: resultColor,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Body Mass Index',
                style: TextStyle(
                  fontSize: 16.sp,
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
