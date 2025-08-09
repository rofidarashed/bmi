// ignore_for_file: unused_field

import 'package:bmi/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderCard extends StatefulWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isMale;

  const GenderCard({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isMale,
  });

  @override
  State<GenderCard> createState() => _GenderCardState();
}

class _GenderCardState extends State<GenderCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get selectedColor =>
      widget.isMale ? AppColors.maleColor : AppColors.femaleColor;
  Color get unselectedColor => AppColors.cardColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _animationController.forward().then((_) {
                    _animationController.reverse();
                  });
                  widget.onTap();
                },
                borderRadius: BorderRadius.circular(20.r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: widget.isSelected
                        ? selectedColor.withOpacity(0.1)
                        : unselectedColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: widget.isSelected
                          ? selectedColor
                          : Colors.transparent,
                      width: 2.w,
                    ),
                    boxShadow: widget.isSelected
                        ? [
                            BoxShadow(
                              color: selectedColor.withOpacity(0.3),
                              blurRadius: 20.r,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8.r,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: widget.isSelected
                              ? selectedColor.withOpacity(0.2)
                              : AppColors.surfaceColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.icon,
                          size: 48.r,
                          color: widget.isSelected
                              ? selectedColor
                              : AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: widget.isSelected
                              ? selectedColor
                              : AppColors.textSecondary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      if (widget.isSelected) ...[
                        SizedBox(height: 8.h),
                        Container(
                          width: 40.w,
                          height: 3.h,
                          decoration: BoxDecoration(
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
