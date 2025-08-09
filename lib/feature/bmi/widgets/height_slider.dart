import 'package:bmi/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeightSlider extends StatelessWidget {
  const HeightSlider({
    super.key,
    required this.height,
    required this.onChanged,
  });

  final double height;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.1),
              blurRadius: 20.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10.h),
            Text(
              "HEIGHT",
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  height.round().toString(),
                  style: TextStyle(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  "cm",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primaryColor,
                inactiveTrackColor: AppColors.surfaceColor,
                thumbColor: AppColors.primaryColor,
                overlayColor: AppColors.primaryColor.withOpacity(0.2),
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
              ),
              child: Slider(
                value: height,
                min: 100,
                max: 220,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
