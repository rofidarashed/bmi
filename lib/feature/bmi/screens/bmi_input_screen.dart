import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/widgets/calculate_button.dart';
import 'package:bmi/feature/bmi/widgets/height_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/gender_card.dart';
import '../widgets/value_adjuster.dart';

class BMIInputScreen extends StatefulWidget {
  const BMIInputScreen({super.key});

  @override
  State<BMIInputScreen> createState() => _BMIInputScreenState();
}

class _BMIInputScreenState extends State<BMIInputScreen>
    with TickerProviderStateMixin {
  bool isMale = true;
  double height = 170;
  int weight = 60;
  int age = 18;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Header with gradient
            Container(
              height: 4.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.secondaryColor,
                    AppColors.accentColor,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Gender Selection
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: GenderCard(
                      isSelected: isMale,
                      icon: Icons.male,
                      label: 'MALE',
                      onTap: () => setState(() => isMale = true),
                      isMale: true,
                    ),
                  ),
                  Expanded(
                    child: GenderCard(
                      isSelected: !isMale,
                      icon: Icons.female,
                      label: 'FEMALE',
                      onTap: () => setState(() => isMale = false),
                      isMale: false,
                    ),
                  ),
                ],
              ),
            ),
            HeightSlider(
              height: height,
              onChanged: (val) => setState(() => height = val),
            ),
            //Weight and age
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ValueAdjuster(
                      label: 'WEIGHT',
                      value: weight,
                      unit: 'kg',
                      onIncrement: () => setState(() => weight++),
                      onDecrement: () =>
                          setState(() => weight > 1 ? weight-- : null),
                    ),
                  ),
                  Expanded(
                    child: ValueAdjuster(
                      label: 'AGE',
                      value: age,
                      unit: 'years',
                      onIncrement: () => setState(() => age++),
                      onDecrement: () => setState(() => age > 1 ? age-- : null),
                    ),
                  ),
                ],
              ),
            ),

            CalculateButton(weight: weight, height: height, isMale: isMale),
          ],
        ),
      ),
    );
  }
}
