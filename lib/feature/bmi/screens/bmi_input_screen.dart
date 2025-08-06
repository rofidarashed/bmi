import 'package:bmi/core/app_animations.dart';
import 'package:bmi/core/app_colors.dart';
import 'package:bmi/feature/bmi/widgets/calculate_button.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    AppAnimations.fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: AppAnimations.fadeAnimation,
        child: Column(
          children: [
            // Header with gradient
            Container(
              height: 4,
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
            const SizedBox(height: 20),

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

            // Height Slider
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "HEIGHT",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          height.round().toString(),
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "cm",
                          style: TextStyle(
                            fontSize: 20,
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
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 24,
                        ),
                      ),
                      child: Slider(
                        value: height,
                        min: 100,
                        max: 220,
                        onChanged: (val) => setState(() => height = val),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Weight and Age
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
