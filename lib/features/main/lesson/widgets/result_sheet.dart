import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';

class ResultSheet extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;
  final VoidCallback onContinue;

  const ResultSheet({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final mainColor =
    isCorrect ? AppColors.textGreenOnSurface250 : AppColors.textRedOnSurface150;

    return Container(
      color: isCorrect ? AppColors.greenSurface250 : AppColors.redSurface150,
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(isCorrect ? Icons.check_circle : Icons.close,
                color: mainColor, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                isCorrect ? 'Tuyệt vời!' : 'Chưa đúng! Đáp án: $correctAnswer',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800,
                    color: mainColor),
              ),
            ),
          ]),
          const SizedBox(height: 24),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: AppButton(
              label: 'TIẾP TỤC',
              variant: isCorrect ? ButtonVariant.primary : ButtonVariant.danger,
              height: 56,
              width: double.infinity,
              textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800,
                color: Colors.white, letterSpacing: 0.5,
              ),
              onPressed: onContinue,
            ),
          ),
        ],
      ),
    );
  }
}