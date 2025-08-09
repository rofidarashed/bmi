  import 'package:bmi/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildBMIGauge(context, {required double bmi, required Color resultColor}) {
    const double minBMI = 15;
    const double maxBMI = 35;
    double normalizedBMI = ((bmi - minBMI) / (maxBMI - minBMI)).clamp(0.0, 1.0);

    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 20.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.underweightColor,
                      AppColors.normalColor,
                      AppColors.overweightColor,
                      AppColors.obeseColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: resultColor.withOpacity(0.3),
                      blurRadius: 10.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 5000),
                curve: Curves.easeOutCubic,
                left: normalizedBMI * (MediaQuery.of(context).size.width - 140),
                top: -10,
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: resultColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: resultColor.withOpacity(0.4),
                        blurRadius: 8.r,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(Icons.place, color: Colors.white, size: 20.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
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
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (label.isNotEmpty) ...[
           SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
