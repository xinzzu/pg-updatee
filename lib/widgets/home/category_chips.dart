import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Chip(
            label: const Text('🔥 All'),
            backgroundColor: const Color(0xFF4C4DDC),
            labelStyle: const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 12),
          Chip(
            label: const Text('🤒 Demam'),
            backgroundColor: const Color(0xFFEDEDFC).withOpacity(0.4),
          ),
          const SizedBox(width: 12),
          Chip(
            label: const Text('🤧 Batuk'),
            backgroundColor: const Color(0xFFEDEDFC).withOpacity(0.4),
          ),
          const SizedBox(width: 12),
          Chip(
            label: const Text('🤢 Pilek'),
            backgroundColor: const Color(0xFFEDEDFC).withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
