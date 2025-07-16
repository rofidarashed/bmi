import 'package:flutter/material.dart';
import '../logic/calculator.dart';
import 'bmi_result_screen.dart';
import '../widgets/gender_card.dart';
import '../widgets/value_adjuster.dart';

class BMIInputScreen extends StatefulWidget {
  const BMIInputScreen({super.key});

  @override
  State<BMIInputScreen> createState() => _BMIInputScreenState();
}

class _BMIInputScreenState extends State<BMIInputScreen> {
  bool isMale = true;
  double height = 170;
  int weight = 60;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                GenderCard(
                  isSelected: isMale,
                  icon: Icons.male,
                  label: 'MALE',
                  onTap: () => setState(() => isMale = true),
                  isMale: true,
                ),
                GenderCard(
                  isSelected: !isMale,
                  icon: Icons.female,
                  label: 'FEMALE',
                  onTap: () => setState(() => isMale = false),
                  isMale: false,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("HEIGHT", style: TextStyle(color: Colors.white70)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        height.round().toString(),
                        style: const TextStyle(fontSize: 40),
                      ),
                      const SizedBox(width: 5),
                      const Text("cm"),
                    ],
                  ),
                  Slider(
                    value: height,
                    min: 100,
                    max: 220,
                    activeColor: Colors.blueGrey,
                    onChanged: (val) => setState(() => height = val),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                ValueAdjuster(
                  label: 'WEIGHT',
                  value: weight,
                  onIncrement: () => setState(() => weight++),
                  onDecrement: () => setState(() => weight--),
                ),
                ValueAdjuster(
                  label: 'AGE',
                  value: age,
                  onIncrement: () => setState(() => age++),
                  onDecrement: () => setState(() => age--),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              final calculator = BMICalculator(
                weight: weight.toDouble(),
                height: height / 100,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BMIResultScreen(
                    bmiValue: calculator.calculateBMI(),
                    resultText: calculator.getResultText(),
                    isMale: isMale,
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.blueGrey,
              width: double.infinity,
              height: 60,
              alignment: Alignment.center,
              child: const Text(
                'CALCULATE',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
