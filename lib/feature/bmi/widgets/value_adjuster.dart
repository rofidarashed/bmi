import 'package:flutter/material.dart';

class ValueAdjuster extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ValueAdjuster({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 20)),
            Text('$value', style: const TextStyle(fontSize: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: onIncrement, icon: const Icon(Icons.add_circle, size: 30)),
                IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove_circle, size: 30)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
