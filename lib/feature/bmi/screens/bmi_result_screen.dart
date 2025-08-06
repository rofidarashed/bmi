import 'package:bmi/core/app_animations.dart';
import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/widgets/bmi_range.dart';
import 'package:bmi/feature/bmi/widgets/custome_result_card.dart';
import 'package:bmi/feature/bmi/widgets/health_advice.dart';
import 'package:bmi/feature/bmi/widgets/result_action_buttons.dart';
import 'package:flutter/material.dart';
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
  ScreenshotController screenshotController = ScreenshotController();

  double get bmi => double.parse(widget.bmiValue);

  Color get resultColor {
    if (bmi < 18.5) return Colors.blue.shade300;
    if (bmi < 25) return Colors.green.shade300;
    if (bmi < 30) return Colors.orange.shade300;
    return Colors.red.shade300;
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

    AppAnimations.fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    AppAnimations.slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
    AppAnimations.scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
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
        title: const Text(
          "Your BMI Result",
          style: TextStyle(
            fontSize: 22,
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
        opacity: AppAnimations.fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  height: 4,
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
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Main Result Card
                Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CustomeResultCard(
                        resultColor: resultColor,
                        widget: widget,
                      ),
                      const SizedBox(height: 32),
                      CustomBMIRange(bmi: bmi, resultColor: resultColor),
                      const SizedBox(height: 24),
                      HealthAdvice(
                        isMale: widget.isMale,
                        weight: widget.weight,
                        height: widget.height,
                        bmi: bmi,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                ResultActionButtons(screenshotController: screenshotController),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

