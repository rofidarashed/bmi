import 'package:flutter/material.dart';

class GenderCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected
                ? (isMale ? Colors.blueAccent : Colors.pinkAccent)
                : const Color(0xFF1D1E33),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}
