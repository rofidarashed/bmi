import 'package:flutter/material.dart';

class BMIResultScreen extends StatefulWidget {
  final String resultText;
  final String bmiValue;
  final bool isMale;

  const BMIResultScreen({
    super.key,
    required this.resultText,
    required this.bmiValue,
    required this.isMale,
  });

  @override
  State<BMIResultScreen> createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  double get bmi => double.parse(widget.bmiValue);
  Color get activeColor =>
      widget.isMale ? Colors.blueAccent.shade100 : Colors.pinkAccent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildBMIBar() {
    const double minBMI = 10;
    const double maxBMI = 40;
    double normalizedBMI = ((bmi - minBMI) / (maxBMI - minBMI)).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.green,
                  Colors.yellow,
                  Colors.orange,
                  Colors.red,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            left: normalizedBMI * MediaQuery.of(context).size.width * 0.85,
            child: Icon(Icons.arrow_drop_down, size: 40, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        title: const Text("Your Result"),
        backgroundColor: widget.isMale ? Colors.blue[900] : Colors.pink[900],
      ),
      body: FadeTransition(
        opacity: _fadeIn,
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF1D1E33),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.resultText,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green.shade200,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                Hero(
                  tag: "bmi_value",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      widget.bmiValue,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: activeColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'BMI (Body Mass Index)',
                  style: TextStyle(fontSize: 18, color: Colors.white60),
                ),
                const SizedBox(height: 32),
                _buildBMIBar(),
                const SizedBox(height: 20),
                Text(
                  'Normal range is 18.5–24.9',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
