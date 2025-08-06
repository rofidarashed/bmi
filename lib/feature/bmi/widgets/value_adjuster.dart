// import 'package:bmi/core/app_animations.dart';
import 'package:bmi/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ValueAdjuster extends StatefulWidget {
  final String label;
  final int value;
  final String unit;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ValueAdjuster({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  State<ValueAdjuster> createState() => _ValueAdjusterState();
}

class _ValueAdjusterState extends State<ValueAdjuster>
    with TickerProviderStateMixin {
  late AnimationController _incrementController;
  late AnimationController _decrementController;
  late Animation<double> _incrementAnimation;
  late Animation<double> _decrementAnimation;

  @override
  void initState() {
    super.initState();
    _incrementController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _decrementController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _incrementAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _incrementController, curve: Curves.easeInOut),
    );
    _decrementAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _decrementController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _incrementController.dispose();
    _decrementController.dispose();
    super.dispose();
  }

  void _handleIncrement() {
    HapticFeedback.lightImpact();
    _incrementController.forward().then((_) {
      _incrementController.reverse();
    });
    widget.onIncrement();
  }

  void _handleDecrement() {
    HapticFeedback.lightImpact();
    _decrementController.forward().then((_) {
      _decrementController.reverse();
    });
    widget.onDecrement();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(8),
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
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.value}',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.unit,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedBuilder(
                animation: _decrementAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _decrementAnimation.value,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleDecrement,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.surfaceColor,
                                AppColors.surfaceColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.remove,
                            color: AppColors.textPrimary,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              AnimatedBuilder(
                animation: _incrementAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _incrementAnimation.value,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleIncrement,
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor,
                                AppColors.secondaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
