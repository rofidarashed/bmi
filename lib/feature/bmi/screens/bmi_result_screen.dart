import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/widgets/bmi_range.dart';
import 'package:bmi/feature/bmi/widgets/custom_result_card.dart';
import 'package:bmi/feature/bmi/widgets/health_advice.dart';
import 'package:bmi/feature/bmi/widgets/result_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

class BMIResultScreen extends StatefulWidget {
  final String resultText;
  final String bmiValue;
  final bool isMale;
  final double weight;
  final double height;

  const BMIResultScreen({
    super.key,
    required this.resultText,
    required this.bmiValue,
    required this.isMale,
    required this.weight,
    required this.height,
  });

  @override
  State<BMIResultScreen> createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  ScreenshotController screenshotController = ScreenshotController();

  double get bmi => double.parse(widget.bmiValue);

  Color get resultColor {
    if (bmi < 18.5) return AppColors.resultBluColor;
    if (bmi < 25) return AppColors.resultGreenColor;
    if (bmi < 30) return AppColors.resultOrangeColor;
    return AppColors.resultRedColor;
  }

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Your BMI Result",
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.isMale
                          ? [AppColors.malePrimary, AppColors.maleSecondary]
                          : [
                              AppColors.femalePrimary,
                              AppColors.femaleSecondary,
                            ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),

                Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      CustomeResultCard(
                        resultColor: resultColor,
                        widget: widget,
                        slideAnimation: _slideAnimation,
                        scaleAnimation: _scaleAnimation,
                      ),
                      SizedBox(height: 32.h),
                      CustomBMIRange(
                        bmi: bmi,
                        resultColor: resultColor,
                        slideAnimation: _slideAnimation,
                      ),
                      SizedBox(height: 24.h),
                      HealthAdvice(
                        isMale: widget.isMale,
                        weight: widget.weight,
                        height: widget.height,
                        bmi: bmi,
                        slideAnimation: _slideAnimation,
                      ),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
                ResultActionButtons(
                  screenshotController: screenshotController,
                  slideAnimation: _slideAnimation,
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
