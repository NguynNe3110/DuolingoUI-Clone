import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupFooter extends StatelessWidget {
  final bool isPromotion;

  const GroupFooter({required this.isPromotion});

  @override
  Widget build(BuildContext context) {
    final color = isPromotion ? AppColors.textGreenOnSurface200 : AppColors.duoRed;
    final label = isPromotion ? 'NHÓM THĂNG HẠNG' : 'NHÓM RỚT HẠNG';
    final arrow =
    isPromotion ? AppIcon.arrowUpward : AppIcon.arrowDownward;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            arrow,
            width: 22,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            arrow,
            width: 22,
          ),
        ],
      ),
    );
  }
}