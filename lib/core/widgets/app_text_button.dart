

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppTextButton extends StatelessWidget {

  final Color textColor;
  final String text;
  final VoidCallback? onPressed ;

  const AppTextButton({
    required this.text,
    this.textColor = AppColors.duoBlue,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}