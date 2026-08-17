// lib/features/main/home/widgets/section_divider.dart
import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  final String title;
  const SectionDivider({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF8B8B8B),
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}