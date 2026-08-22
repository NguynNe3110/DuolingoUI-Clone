import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum ChipWordStatus {
  idle,
  selected,
  correct,
  wrong,
  disabled,
}

class AppChipWord extends StatelessWidget {
  final Widget child;
  final ChipWordStatus status;
  final bool fillWidth;
  final VoidCallback? onPressed;
  final EdgeInsets padding;

  const AppChipWord({
    super.key,
    required this.child,
    required this.status,
    this.onPressed,
    this.fillWidth = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.S16,
      vertical: AppSpacing.S12,
    ),
  });

  // ── Palette ──
  Color _backgroundColor() => switch (status) {
    ChipWordStatus.idle => AppColors.background,
    ChipWordStatus.selected => AppColors.blueSurface150,
    ChipWordStatus.correct => AppColors.greenSurface250,
    ChipWordStatus.wrong => AppColors.redSurface150,
    ChipWordStatus.disabled => AppColors.background,
  };

  Color _textColor() => switch (status) {
    ChipWordStatus.idle => AppColors.textOnBackground,
    ChipWordStatus.selected => AppColors.textBlueOnSurface150,
    ChipWordStatus.correct => AppColors.textGreenOnSurface250,
    ChipWordStatus.wrong => AppColors.textRedOnSurface150,
    ChipWordStatus.disabled => AppColors.grayBorder200,
  };

  Color _borderColor() => switch (status) {
    ChipWordStatus.idle => AppColors.grayBorder200,
    ChipWordStatus.selected => AppColors.blueBorder150,
    ChipWordStatus.correct => AppColors.greenBorder250,
    ChipWordStatus.wrong => AppColors.redBorder150,
    ChipWordStatus.disabled => AppColors.grayBorder200,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: fillWidth ? Alignment.center : null,
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(AppRadius.r14),
          border: Border.all(color: _borderColor(), width: AppBorder.b2),
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: _textColor()),
          child: IconTheme(
            data: IconThemeData(color: _textColor()),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}