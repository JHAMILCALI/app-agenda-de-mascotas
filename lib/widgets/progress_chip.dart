import 'package:flutter/material.dart';

class ProgressChip extends StatelessWidget {
  final int value;
  final String label;
  final Color color;

  const ProgressChip({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color.withOpacity(0.1),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$value',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
