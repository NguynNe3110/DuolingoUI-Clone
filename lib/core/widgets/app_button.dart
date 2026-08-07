import 'dart:async';

import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class AppButton extends StatefulWidget {
  final String label;
  final String? iconPath;

  // 1. Mở khóa các biến custom color
  final Color? backgroundColor;
  final Color? depthColor;
  final Color? textColor;

  final ButtonVariant variant;
  final bool isEnabled;

  final TextStyle? textStyle;
  final Color? borderColor;
  final double? height;
  final double? width;

  final double? depth;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.label,
    this.iconPath,
    this.backgroundColor, // Custom nền
    this.depthColor,      // Custom độ sâu (shadow)
    this.textColor,       // Custom chữ
    this.variant = ButtonVariant.primary,
    this.isEnabled = true,
    this.borderColor,
    this.textStyle,
    this.height,
    this.width,
    this.depth,
    this.onPressed,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  // static const double _depth =  3.5;
  bool _pressed = false;
  Timer? _releaseTimer;

  @override
  void dispose() {
    _releaseTimer?.cancel();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _releaseTimer?.cancel();
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    _releaseTimer = Timer(const Duration(milliseconds: 80), () {
      if (mounted) setState(() => _pressed = false);
    });
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _releaseTimer?.cancel();
    setState(() => _pressed = false);
  }

  double _calculateAutoDepth(Color depthColor) {
    if (depthColor == AppColors.grayBorder200 ||
        depthColor == Colors.transparent) {
      return 1.9;
    }

    return 3.5;
  }
  @override
  Widget build(BuildContext context) {
    // 2. Lấy bảng màu gốc từ Variant
    final basePalette = ButtonPalette.resolve(widget.variant, widget.isEnabled);
    final canTap = widget.isEnabled && widget.onPressed != null;
    final textTheme = Theme.of(context).textTheme;

    // 3. CƠ CHẾ OVERRIDE: Custom Color ?? Variant Color
    final finalBgColor = widget.backgroundColor ?? basePalette.backgroundColor;
    final finalDepthColor = widget.depthColor ?? basePalette.depthColor;
    final finalTextColor = widget.textColor ?? basePalette.textColor;
    final finalBorderColor = widget.borderColor ?? basePalette.borderColor;

    final finalDepth = widget.depth ?? _calculateAutoDepth(finalDepthColor);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: canTap ? _handleTapDown : null,
      onTapUp: canTap ? _handleTapUp : null,
      onTapCancel: canTap ? _handleTapCancel : null,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
        curve: Curves.easeOut,
        height: widget.height ?? 44,
        width: widget.width,
        alignment: Alignment.center,
        transform: Matrix4.translationValues(
          0,
          (_pressed && canTap) ? finalDepth : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: finalBgColor, // Dùng màu đã override
          borderRadius: BorderRadius.circular(AppRadius.r14), //14
          border: finalBorderColor != null
              ? Border.all(color: finalBorderColor, width: 1.8)
              : null,
          boxShadow: finalDepthColor == Colors.transparent
              ? null
              : [
            BoxShadow(
              color: finalDepthColor, // Dùng màu đã override
              offset: Offset(0, (_pressed && canTap) ? 0 : finalDepth),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.iconPath != null) ...[
              // Nếu có custom textColor thì tint luôn icon cho đồng bộ (optional)
              SvgPicture.asset(
                widget.iconPath!,
                width: 20,
                height: 20,
                // colorFilter: ColorFilter.mode(finalTextColor, BlendMode.srcIn),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: widget.textStyle ??
                  textTheme.labelMedium?.copyWith(color: finalTextColor), // Dùng màu đã override
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonVariant {
  primary,    // xanh lá (hành động chính)
  danger,     // đỏ (trả lời sai, xoá)
  secondary,  // xanh dương (hành động phụ)
  neutral,    // trắng/xám (huỷ, back)
  ghost,      // trong suốt (link, text button)
}

class ButtonPalette {
  final Color backgroundColor;
  final Color depthColor;
  final Color textColor;
  final Color? borderColor;

  ButtonPalette({
    required this.backgroundColor,
    required this.depthColor,
    required this.textColor,
    this.borderColor,
  });

  static ButtonPalette resolve(ButtonVariant variant, bool enabled) {
    switch (variant) {
      case ButtonVariant.primary:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.duoGreen      : AppColors.duoGreen.withOpacity(0.4),
          depthColor:      enabled ? AppColors.duoGreenDark  : AppColors.duoGreenDark.withOpacity(0.4),
          textColor:       Colors.white,
        );

      case ButtonVariant.danger:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.duoRed : AppColors.duoRed.withOpacity(0.4),
          depthColor:      enabled ? AppColors.duoRedDark : AppColors.duoRedDark.withOpacity(0.4),
          textColor:       Colors.white,
        );

      case ButtonVariant.secondary:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.duoBlue : AppColors.duoBlue.withOpacity(0.4),
          depthColor:      enabled ? AppColors.duoBlueDark : AppColors.duoBlueDark.withOpacity(0.4),
          textColor:       Colors.white,
        );

      case ButtonVariant.neutral:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.background    : AppColors.background.withOpacity(0.5),
          depthColor:      enabled ? AppColors.grayBorder200 : const Color(0xFFBDBDBD).withOpacity(0.4),
          textColor:       enabled ? AppColors.borderDark    : Colors.black38,
          borderColor:     enabled ? AppColors.grayBorder200 : null,
        );

      case ButtonVariant.ghost:
        return ButtonPalette(
          backgroundColor: AppColors.disabledBg,
          depthColor:      Colors.transparent,
          textColor:       AppColors.background,
        );
    }
  }
}