import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_icon.dart';

/// ========================= WIDGET DÙNG CHUNG =========================

/// Header section: "NHIỆM VỤ ... | ⏰ X NGÀY"
class SectionHeader extends StatelessWidget {
  final String title;
  final String timeLabel;

  const SectionHeader({required this.title, required this.timeLabel, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF9C9C9C),
            letterSpacing: 0.8,
          ),
        ),
        const Spacer(),
        SvgPicture.asset(
          AppIcon.timeDisable,
          width: 18,
        ),
        const SizedBox(width: 4),
        Text(
          timeLabel,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF333333),
          ),
        ),
      ],
    );
  }
}